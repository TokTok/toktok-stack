#define _DEFAULT_SOURCE
#include "csource.h"

#include <string.h>

static char answer_data[sizeof(int)];

int get_answer(int question) {
  int previous_answer;
  memcpy(&previous_answer, answer_data, sizeof(int));
  explicit_bzero(answer_data, sizeof(int));
  memcpy(answer_data, &previous_answer, sizeof(int));

  return previous_answer;
}
