#include <sodium.h>
#include <stdio.h>

static const char message[] = "hello world";
static const char expected_hash[crypto_generichash_BYTES] =
    "\x25\x6c\x83\xb2\x97\x11\x4d\x20\x1b\x30\x17\x9f\x3f\x0e\xf0\xca"
    "\xce\x97\x83\x62\x2d\xa5\x97\x43\x26\xb4\x36\x17\x8a\xee\xf6\x10";

// Check whether we can get a hash of a message.
int main(void)
{
    if (sodium_init() < 0) {
        return 1;
    }

    unsigned char hash[crypto_generichash_BYTES];
    crypto_generichash(hash, sizeof hash, (const unsigned char*)message, sizeof message - 1, NULL, 0);

    for (size_t i = 0; i < sizeof hash; i++) {
        if (hash[i] != expected_hash[i]) {
            fprintf(stderr, "expected: ");
            for (size_t j = 0; j < sizeof expected_hash; j++) {
                fprintf(stderr, "%02x", expected_hash[j]);
            }
            fputc('\n', stderr);
            fprintf(stderr, "actual:   ");
            for (size_t j = 0; j < sizeof hash; j++) {
                fprintf(stderr, "%02x", hash[j]);
            }
            fputs("\n          ", stderr);
            for (size_t j = 0; j < i; j++) {
                fputs("  ", stderr);
            }
            fputs("^^\n", stderr);
            return 1;
        }
    }

    return 0;
}
