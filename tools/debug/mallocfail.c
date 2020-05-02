#include <unistd.h>

// This "malloc" library is empty apart from this initialiser, just to have a
// timeout for tests, because mallocfail doesn't terminate otherwise.
static __attribute__((__constructor__)) void init(void) {
  alarm(2);
}
