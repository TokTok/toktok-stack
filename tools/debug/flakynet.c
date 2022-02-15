/* SPDX-License-Identifier: GPL-3.0-or-later
 * Copyright © 2020 The TokTok team.
 */

/**
 * flakynet: A simple LD_PRELOAD wrapper dropping UDP packets sent via sendto().
 *
 * Compile with: cc flakynet.c -o flakynet.so -shared -fPIC -ldl
 *
 * Use like this:
 *   LD_PRELOAD=flakynet.so ./my_test
 *
 * If you compiled with asan, you need to preload that first:
 *   LD_PRELOAD=libasan.so.5:flakynet.so ./my_test
 *
 * See below for configuration options set through environment variables.
 */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <errno.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>

/**
 * FLAKYNET_FLAKINESS controls the flakiness, set between 0 and 1 with 0 being
 * not flaky at all, and 1 blocking all packets, so no outgoing UDP traffic
 * happens at all. This defaults to 0.2, i.e. 20% packet loss.
 */
static double flakiness = 0.2;
/**
 * FLAKYNET_SEED can be used to seed the RNG, so you can try different values
 * here to get different packets dropped.
 */
static unsigned int seed = 0;
/**
 * FLAKYNET_HEADSTART can be set to a positive integer to give the program an
 * initially stable network after which the flakiness begins. Use this if your
 * program doesn't deal well with dropped packets on building the connection,
 * but should deal well with packet loss afterwards.
 */
static unsigned int headstart = 0;
/**
 * Set FLAKYNET_VERBOSE=1 to print the length and first byte of every packet
 * dropped.
 */
static bool verbose = false;
/**
 * Set FLAKYNET_SYSCALLS=1 to return errors from the sendto syscall instead of
 * dropping the packet.
 */
static bool flaky_syscalls = false;

static __attribute__((__constructor__)) void init(void) {
  const char *env_headstart = getenv("FLAKYNET_HEADSTART");
  if (env_headstart != NULL) {
    char *end = NULL;
    headstart = strtol(env_headstart, &end, 10);
    if (end == NULL || *end != '\0') {
      fprintf(stderr, "flakynet: invalid value for FLAKYNET_HEADSTART: %s\n", env_headstart);
      abort();
    }
  }

  const char *env_seed = getenv("FLAKYNET_SEED");
  if (env_seed != NULL) {
    char *end = NULL;
    seed = strtol(env_seed, &end, 10);
    if (end == NULL || *end != '\0') {
      fprintf(stderr, "flakynet: invalid value for FLAKYNET_SEED: %s\n", env_seed);
      abort();
    }
  }

  const char *env_flakiness = getenv("FLAKYNET_FLAKINESS");
  if (env_flakiness != NULL) {
    char *end = NULL;
    flakiness = strtod(env_flakiness, &end);
    if (end == NULL || *end != '\0') {
      fprintf(stderr, "flakynet: invalid value for FLAKYNET_FLAKINESS: %s\n", env_flakiness);
      abort();
    }
  }

  const char *env_verbose = getenv("FLAKYNET_VERBOSE");
  verbose = env_verbose != NULL && *env_verbose == '1';

  const char *env_syscalls = getenv("FLAKYNET_SYSCALLS");
  flaky_syscalls = env_syscalls != NULL && *env_syscalls == '1';
}

static bool can_send(void) {
  if (headstart > 0) {
    fprintf(stderr, "flakynet: headstart = %u\n", headstart);
    --headstart;
    return true;
  }
  return (double)rand_r(&seed) / (double)RAND_MAX > flakiness;
}

ssize_t sendto(int sockfd, const void *buf, size_t len, int flags, const struct sockaddr *dest_addr,
               socklen_t addrlen) {
  typedef __typeof__(sendto) sendto_type;
  static sendto_type *libc_sendto;
  if (libc_sendto == NULL) {
    libc_sendto = (sendto_type *)dlsym(RTLD_NEXT, "sendto");
  }

  if (can_send()) {
    return libc_sendto(sockfd, buf, len, flags, dest_addr, addrlen);
  }

  if (flaky_syscalls) {
    if (len > 0 && verbose) {
      fprintf(stderr, "flakynet: rejecting packet of length %zu, packet[0] = 0x%02x\n", len,
              ((const char *)buf)[0]);
    }

    errno = 11;
    return -1;
  }

  if (len > 0 && verbose) {
    fprintf(stderr, "flakynet: dropping packet of length %zu, packet[0] = 0x%02x\n", len,
            ((const char *)buf)[0]);
  }

  // Success, but we don't actually send.
  return len;
}
