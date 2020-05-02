#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// This "malloc" library is empty apart from this initialiser, just to have a
// timeout for tests, because mallocfail doesn't terminate otherwise.
static __attribute__((__constructor__)) void init(void) {
  long timeout = 0;

  const char *env_timeout = getenv("MALLOCFAIL_TIMEOUT");
  if (env_timeout != NULL) {
    char *end = NULL;
    timeout = strtol(env_timeout, &end, 10);
    if (end == NULL || *end != '\0') {
      fprintf(stderr, "mallocfail: invalid value for MALLOCFAIL_TIMEOUT: %s\n",
              env_timeout);
      abort();
    }
  }

  // If a timeout was not set, we may be running in a debugger, and don't want
  // a timeout at all.
  if (timeout != 0) {
    alarm(timeout);
  }
}
