/*
 * generated by external/ncurses/ncurses/tinfo/MKuserdefs.sh
 */

/*
 *    comp_userdefs.c -- The names of widely used user-defined capabilities
 *                       indexed via a hash table for the compiler.
 *
 */

#include <curses.priv.h>
#include <tic.h>
#include <hashsize.h>

#if NCURSES_XNAMES
/* 11 collisions out of 98 entries */
static const char user_names_text[] = \
                                      "CO\0" "E3\0" "RGB\0" "TS\0" "U8\0" "XM\0" "grbom\0" "gsbom\0" "xm\0" \
                                      "Rmol\0" "Smol\0" "blink2\0" "norm\0" "opaq\0" "setal\0" "smul2\0" \
                                      "AN\0" "AX\0" "C0\0" "C8\0" "CE\0" "CS\0" "E0\0" "G0\0" "KJ\0" "OL\0" \
                                      "S0\0" "TF\0" "WS\0" "XC\0" "XT\0" "Z0\0" "Z1\0" "Cr\0" "Cs\0" "Csr\0" \
                                      "Ms\0" "Se\0" "Smulx\0" "Ss\0" "rmxx\0" "smxx\0" "kDC3\0" "kDC4\0" \
                                      "kDC5\0" "kDC6\0" "kDC7\0" "kDN\0" "kDN3\0" "kDN4\0" "kDN5\0" "kDN6\0" \
                                      "kDN7\0" "kEND3\0" "kEND4\0" "kEND5\0" "kEND6\0" "kEND7\0" "kHOM3\0" \
                                      "kHOM4\0" "kHOM5\0" "kHOM6\0" "kHOM7\0" "kIC3\0" "kIC4\0" "kIC5\0" \
                                      "kIC6\0" "kIC7\0" "kLFT3\0" "kLFT4\0" "kLFT5\0" "kLFT6\0" "kLFT7\0" \
                                      "kNXT3\0" "kNXT4\0" "kNXT5\0" "kNXT6\0" "kNXT7\0" "kPRV3\0" "kPRV4\0" \
                                      "kPRV5\0" "kPRV6\0" "kPRV7\0" "kRIT3\0" "kRIT4\0" "kRIT5\0" "kRIT6\0" \
                                      "kRIT7\0" "kUP\0" "kUP3\0" "kUP4\0" "kUP5\0" "kUP6\0" "kUP7\0" "ka2\0" \
                                      "kb1\0" "kb3\0" "kc2\0" ;

static user_table_data const user_names_data[] =
{
    {               0,	(1<<NUMBER),	0,0,	  0,  -1 },
    {               3,	(1<<STRING),	0,0,	  0,  -1 },
    {               6,	(1<<BOOLEAN|1<<NUMBER|1<<STRING),	0,0,	  1,  -1 },
    {              10,	(1<<STRING),	0,0,	  2,  -1 },
    {              13,	(1<<NUMBER),	0,0,	  2,  -1 },
    {              16,	(1<<STRING),	1,0,	  3,  -1 },
    {              19,	(1<<STRING),	0,0,	  4,  -1 },
    {              25,	(1<<STRING),	0,0,	  5,  -1 },
    {              31,	(1<<STRING),	8,8,	 14,  -1 },
    {              34,	(1<<STRING),	0,0,	 15,  -1 },
    {              39,	(1<<STRING),	0,0,	 16,  -1 },
    {              44,	(1<<STRING),	0,0,	 17,  -1 },
    {              51,	(1<<STRING),	0,0,	 18,  -1 },
    {              56,	(1<<STRING),	0,0,	 19,  -1 },
    {              61,	(1<<STRING),	1,0,	 20,  -1 },
    {              67,	(1<<STRING),	0,0,	 21,  -1 },
    {              73,	(1<<BOOLEAN),	0,0,	  1,  -1 },
    {              76,	(1<<BOOLEAN),	0,0,	  2,  -1 },
    {              79,	(1<<STRING),	0,0,	 22,  -1 },
    {              82,	(1<<BOOLEAN),	0,0,	  3,  -1 },
    {              85,	(1<<STRING),	0,0,	 23,  -1 },
    {              88,	(1<<STRING),	0,0,	 24,  -1 },
    {              91,	(1<<STRING),	0,0,	 25,  -1 },
    {              94,	(1<<BOOLEAN),	0,0,	  4,  -1 },
    {              97,	(1<<STRING),	1,1,	 26,  -1 },
    {             100,	(1<<NUMBER),	0,0,	  3,  -1 },
    {             103,	(1<<STRING),	1,1,	 27,  -1 },
    {             106,	(1<<BOOLEAN),	0,0,	  5,  -1 },
    {             109,	(1<<STRING),	2,0,	 28,  -1 },
    {             112,	(1<<STRING),	1,1,	 29,  -1 },
    {             115,	(1<<BOOLEAN),	0,0,	  6,  -1 },
    {             118,	(1<<STRING),	0,0,	 30,  -1 },
    {             121,	(1<<STRING),	0,0,	 31,  -1 },
    {             124,	(1<<STRING),	0,0,	 32,  -1 },
    {             127,	(1<<STRING),	1,1,	 33,  -1 },
    {             130,	(1<<STRING),	1,0,	 34,  -1 },
    {             134,	(1<<STRING),	2,3,	 35,  -1 },
    {             137,	(1<<STRING),	0,0,	 36,  -1 },
    {             140,	(1<<STRING),	1,0,	 37,  -1 },
    {             146,	(1<<STRING),	1,0,	 38,  -1 },
    {             149,	(1<<STRING),	0,0,	 39,  -1 },
    {             154,	(1<<STRING),	0,0,	 40,  -1 },
    {             159,	(1<<STRING),	0,0,	 41,  -1 },
    {             164,	(1<<STRING),	0,0,	 42,  -1 },
    {             169,	(1<<STRING),	0,0,	 43,  -1 },
    {             174,	(1<<STRING),	0,0,	 44,  -1 },
    {             179,	(1<<STRING),	0,0,	 45,  16 },
    {             184,	(1<<STRING),	0,0,	 46,  -1 },
    {             188,	(1<<STRING),	0,0,	 47,  -1 },
    {             193,	(1<<STRING),	0,0,	 48,  -1 },
    {             198,	(1<<STRING),	0,0,	 49,  -1 },
    {             203,	(1<<STRING),	0,0,	 50,  17 },
    {             208,	(1<<STRING),	0,0,	 51,  -1 },
    {             213,	(1<<STRING),	0,0,	 52,  -1 },
    {             219,	(1<<STRING),	0,0,	 53,  -1 },
    {             225,	(1<<STRING),	0,0,	 54,  15 },
    {             231,	(1<<STRING),	0,0,	 55,  -1 },
    {             237,	(1<<STRING),	0,0,	 56,  -1 },
    {             243,	(1<<STRING),	0,0,	 57,  -1 },
    {             249,	(1<<STRING),	0,0,	 58,  -1 },
    {             255,	(1<<STRING),	0,0,	 59,  -1 },
    {             261,	(1<<STRING),	0,0,	 60,  -1 },
    {             267,	(1<<STRING),	0,0,	 61,  -1 },
    {             273,	(1<<STRING),	0,0,	 62,  -1 },
    {             278,	(1<<STRING),	0,0,	 63,  -1 },
    {             283,	(1<<STRING),	0,0,	 64,  -1 },
    {             288,	(1<<STRING),	0,0,	 65,  -1 },
    {             293,	(1<<STRING),	0,0,	 66,  -1 },
    {             298,	(1<<STRING),	0,0,	 67,  60 },
    {             304,	(1<<STRING),	0,0,	 68,  61 },
    {             310,	(1<<STRING),	0,0,	 69,  62 },
    {             316,	(1<<STRING),	0,0,	 70,  -1 },
    {             322,	(1<<STRING),	0,0,	 71,  -1 },
    {             328,	(1<<STRING),	0,0,	 72,  -1 },
    {             334,	(1<<STRING),	0,0,	 73,  -1 },
    {             340,	(1<<STRING),	0,0,	 74,  -1 },
    {             346,	(1<<STRING),	0,0,	 75,  -1 },
    {             352,	(1<<STRING),	0,0,	 76,  -1 },
    {             358,	(1<<STRING),	0,0,	 77,  -1 },
    {             364,	(1<<STRING),	0,0,	 78,  -1 },
    {             370,	(1<<STRING),	0,0,	 79,  73 },
    {             376,	(1<<STRING),	0,0,	 80,  74 },
    {             382,	(1<<STRING),	0,0,	 81,  75 },
    {             388,	(1<<STRING),	0,0,	 82,  -1 },
    {             394,	(1<<STRING),	0,0,	 83,  -1 },
    {             400,	(1<<STRING),	0,0,	 84,  -1 },
    {             406,	(1<<STRING),	0,0,	 85,  -1 },
    {             412,	(1<<STRING),	0,0,	 86,  -1 },
    {             418,	(1<<STRING),	0,0,	 87,  -1 },
    {             422,	(1<<STRING),	0,0,	 88,  -1 },
    {             427,	(1<<STRING),	0,0,	 89,  -1 },
    {             432,	(1<<STRING),	0,0,	 90,  -1 },
    {             437,	(1<<STRING),	0,0,	 91,  -1 },
    {             442,	(1<<STRING),	0,0,	 92,  -1 },
    {             447,	(1<<STRING),	0,0,	 93,  -1 },
    {             451,	(1<<STRING),	0,0,	 94,  94 },
    {             455,	(1<<STRING),	0,0,	 95,  -1 },
    {             459,	(1<<STRING),	0,0,	 96,  96 }
};

static struct user_table_entry *_nc_user_table = 0;

static const HashValue _nc_user_hash_table[995] =
{
    -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        65,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        69,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        48,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        7,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        52,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        83,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        95,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        87,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        54,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        27,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        81,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        37,
        42,
        -1,
        -1,
        -1,
        -1,
        11,
        -1,
        -1,
        -1,
        -1,
        24,
        -1,
        -1,
        -1,
        -1,
        90,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        14,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        46,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        58,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        66,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        35,
        -1,
        70,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        49,
        -1,
        8,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        84,
        -1,
        -1,
        40,
        41,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        13,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        55,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        29,
        -1,
        -1,
        78,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        82,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        43,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        38,
        12,
        -1,
        -1,
        -1,
        -1,
        91,
        -1,
        -1,
        -1,
        -1,
        -1,
        18,
        -1,
        22,
        -1,
        23,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        63,
        -1,
        0,
        26,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        31,
        59,
        -1,
        2,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        67,
        -1,
        21,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        71,
        -1,
        -1,
        -1,
        -1,
        -1,
        33,
        -1,
        3,
        -1,
        19,
        28,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        50,
        -1,
        -1,
        -1,
        -1,
        4,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        85,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        97,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        56,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        79,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        76,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        44,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        25,
        92,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        64,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        32,
        68,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        88,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        72,
        -1,
        -1,
        6,
        -1,
        -1,
        34,
        -1,
        -1,
        -1,
        -1,
        -1,
        30,
        -1,
        -1,
        -1,
        36,
        -1,
        -1,
        -1,
        -1,
        -1,
        39,
        51,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        47,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        86,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        53,
        -1,
        -1,
        -1,
        -1,
        9,
        10,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        20,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        57,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        80,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        89,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        77,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        45,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        93,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        5,
        -1,
        -1,
        0	/* base-of-table */
    };


#define USERTABSIZE SIZEOF(user_names_data)

#if 1
static void
next_string(const char *strings, unsigned *offset)
{
    *offset += (unsigned) strlen(strings + *offset) + 1;
}

static const struct user_table_entry *
_nc_build_names(struct user_table_entry **actual,
                const user_table_data *source,
                const char *strings)
{
    if (*actual == 0) {
        *actual = typeCalloc(struct user_table_entry, USERTABSIZE);
        if (*actual != 0) {
            unsigned n;
            unsigned len = 0;
            for (n = 0; n < USERTABSIZE; ++n) {
                (*actual)[n].ute_name = strings + len;
                (*actual)[n].ute_type = (int) source[n].ute_type;
                (*actual)[n].ute_argc = source[n].ute_argc;
                (*actual)[n].ute_args = source[n].ute_args;
                (*actual)[n].ute_index = source[n].ute_index;
                (*actual)[n].ute_link = source[n].ute_link;
                next_string(strings, &len);
            }
        }
    }
    return *actual;
}

#define build_names(root) _nc_build_names(&_nc_##root##_table, \
					  root##_names_data, \
					  root##_names_text)
#else
#define build_names(root) _nc_ ## root ## _table
#endif

NCURSES_EXPORT(const struct user_table_entry *) _nc_get_userdefs_table (void)
{
    return build_names(user) ;
}

static HashValue
info_hash(const char *string)
{
    long sum = 0;

    DEBUG(9, ("hashing %s", string));
    while (*string) {
        sum += (long) (*string + (*(string + 1) << 8));
        string++;
    }

    DEBUG(9, ("sum is %ld", sum));
    return (HashValue) (sum % HASHTABSIZE);
}

static int
compare_info_names(const char *a, const char *b)
{
    return !strcmp(a, b);
}

static const HashData hash_data[] = {
    { HASHTABSIZE, _nc_user_hash_table, info_hash, compare_info_names }
};

NCURSES_EXPORT(const HashData *) _nc_get_hash_user (void)
{
    return hash_data;
}

#if NO_LEAKS
NCURSES_EXPORT(void) _nc_comp_userdefs_leaks(void)
{
#if 1
    FreeIfNeeded(_nc_user_table);
#endif
}
#endif /* NO_LEAKS */

#else /*! NCURSES_XNAMES */
NCURSES_EXPORT(void) _nc_comp_userdefs(void);
NCURSES_EXPORT(void) _nc_comp_userdefs(void) { }
#endif /* NCURSES_XNAMES */
