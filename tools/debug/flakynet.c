/* SPDX-License-Identifier: GPL-3.0-or-later
 * Copyright © 2020 The TokTok team.
 */

/**
 * flakynet: A simple LD_PRELOAD wrappet for UDP packet sending via sendto().
 *
 * Compile with: cc flakynet.c -o flakynet.so -shared -fPIC -ldl
 *
 * Use like this:
 *   LD_PRELOAD=flakynet.so ./my_test
 *
 * If you compiled with asan, you need to preload that first:
 *   LD_PRELOAD=libasan.so.5:flakynet.so ./my_test
 *
 * You can control the flakiness using the FLAKYNET_FLAKINESS environment
 * variable, set between 0 and 1 with 0 being not flaky at all, and 1 blocking
 * all packets, so no outgoing UDP traffic happens at all. This defaults to 0.2,
 * i.e. 20% packet loss.
 *
 * FLAKYNET_SEED can be used to seed the RNG, so you can try different values
 * here to get different packets dropped.
 *
 * Set FLAKYNET_VERBOSE=1 to print the length and first byte of every packet
 * dropped.
 */
#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/types.h>

static unsigned int seed = 0;
static double flakiness = 0.2;
static bool verbose = false;

static __attribute__((__constructor__)) void init(void) {
    const char *env_seed = getenv("FLAKYNET_SEED");
    if (env_seed != NULL) {
        char *end = NULL;
        seed = strtol(env_seed, &end, 10);
        if (end == NULL || *end != '\0') {
            fprintf(stderr, "flakynet: invalid value for FLAKYNET_SEED: %s\n",
                    env_seed);
            abort();
        }
    }

    const char *env_flakiness = getenv("FLAKYNET_FLAKINESS");
    if (env_flakiness != NULL) {
        char *end = NULL;
        flakiness = strtod(env_flakiness, &end);
        if (end == NULL || *end != '\0') {
            fprintf(stderr, "flakynet: invalid value for FLAKYNET_FLAKINESS: %s\n",
                    env_flakiness);
            abort();
        }
    }

    const char *env_verbose = getenv("FLAKYNET_VERBOSE");
    verbose = env_verbose != NULL && *env_verbose == '1';
}

ssize_t sendto(int sockfd, const void *buf, size_t len, int flags,
               const struct sockaddr *dest_addr, socklen_t addrlen) {
    typedef __typeof__(sendto) sendto_type;
    static sendto_type *libc_sendto;
    if (libc_sendto == NULL) {
        libc_sendto = (sendto_type *)dlsym(RTLD_NEXT, "sendto");
    }

    if ((double)rand_r(&seed) / (double)RAND_MAX < flakiness) {
        // Success, but we don't actually send.
        if (len > 0 && verbose) {
            fprintf(stderr,
                    "flakynet: dropping packet of length %zu, packet[0] = 0x%02x\n",
                    len, ((const char *)buf)[0]);
        }
        return len;
    }
    return libc_sendto(sockfd, buf, len, flags, dest_addr, addrlen);
}
