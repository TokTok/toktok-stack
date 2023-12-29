#define _DEFAULT_SOURCE
#include "csource.h"

#include <sodium.h>
#include <string.h>

static char answer_data[sizeof(int)];

int get_answer(int question) {
  int previous_answer;
  memcpy(&previous_answer, answer_data, sizeof(int));
  // Not available in the default zig toolchain, so tests whether we have the
  // correct glibc.
  explicit_bzero(answer_data, sizeof(int));
  memcpy(answer_data, &previous_answer, sizeof(int));

  // Check that we can link against libsodium.
  if (question >= randombytes_uniform(42)) {
    return 42;
  }

  return previous_answer + 23;
}
