/* SPDX-License-Identifier: GPL-3.0-or-later
 * Copyright © 2025 The TokTok team.
 */

#include <QBuffer>
#include <QByteArray>
#include <QImage>
#include <QImageIOPlugin>
#include <QPluginLoader>
#include <QTest>

#include <cassert>
#include <cstddef>
#include <dlfcn.h>

// Check if allocation size isn't too big, then call glibc's malloc.
static void* (*libc_malloc)(size_t);
static bool malloc_failed = false;

void* malloc(size_t size)
{
    if (!malloc_failed && size < 100 * 1024 * 1024) {
        malloc_failed = true;
    }
    if (!libc_malloc) {
        libc_malloc = reinterpret_cast<void* (*)(size_t)>(dlsym(RTLD_NEXT, "malloc"));
    }
    return libc_malloc(size);
}

class TestQImage : public QObject
{
    Q_OBJECT

private slots:
    void testANI();
    void testXCF();
    void testXCFSlow();
};

// https://bugs.kde.org/show_bug.cgi?id=498368
#define BUG_498368_FIXED 1
void TestQImage::testANI()
{
#if BUG_498368_FIXED
    malloc_failed = false;

    const QByteArray data = QByteArray::fromBase64( //
        "AFJJRkYOAACAQUNPTgB+YAAAAAAAUklGRg4AAIBBQ09OAH5gAAAAAABzZXEgANra2tra2tra2tra2t"
        "ra2tra2tra2tra2tra2tra2tra2traAAAAAAAAAAAAAAAAAF0=");

    QImage::fromData(data.mid(1), "ANI");
    QVERIFY(!malloc_failed);
#endif
}

// https://bugs.kde.org/show_bug.cgi?id=498380
#define BUG_498380_FIXED 1
void TestQImage::testXCF()
{
#if BUG_498380_FIXED
    const QByteArray data = QByteArray::fromBase64(
        "AWdpbXAgeGNmAAAwAAoAAABbAAAAAzMAAAAAAAAAAAAAAAAAAAAgCHAAAC0AAAAAAAgAAAAAAAAg"
        "8AAAAAAAAAAACAAAAAAgAPAAAAAACgCAAAAAAAAAAAAJ2/AAAAAAAAAAACMAAAAACHAAAAAAAAAA"
        "AAgAAAAAAAAg8AAAAAAAAAAACAAAAAAgXPAAAAAACgCAAAAAAAAAAAAJ2/AAAAAAAAAAACIAAAAI"
        "cAAALQAAAAAACAAAAAAAIAhwAAAtAAAAAAAIAAAAAAAAIPAAAAAAAAAAAAgAAAAAIADwAAAAAAoA"
        "gAAAAAAAAAAACdvwAAAAAAAAAAAjAAAKAIAAAAAAAAAAAAnb8AAAAAAAAAAAIgAAAAhwAAAtAAAA"
        "AAAIAAAAAAAgCHAAAAAAAAAg8AAAAAAAAAAACAAAAAAgAPAAPwAACgCAAAAAAAAAAAAJ2/AAAAAA"
        "AAAAAPAAIABQSApg");

    QImage::fromData(data.mid(1), "XCF");
#endif
}

// https://bugs.kde.org/show_bug.cgi?id=498381
#define BUG_498381_FIXED 1
void TestQImage::testXCFSlow()
{
#if BUG_498381_FIXED
    const QByteArray data = QByteArray::fromBase64(
        "AWdpbXAgeGNmAAAwAAoAAABbAAAAAzMAAAAAAAAAAAAAAAYAcAEAAAAAAwAAAAAAAf//////bW1t"
        "bW1tbW1tbW1tbW1tbW3/////////////bW1tnZ2dnZ2dnZ2dJSFQUy1BZG9iZZ2dnZ2dnZ2dnZ2d"
        "nZ2dnZ2dnZ2dnXJycnJycnJycnJycnJycnJycnJycnJycnJtfm1tbW1tbW1tAAAAAAAAAAABMQAA"
        "7wYAAAAAAAAAAQAAAAAAAAAAAAAAAAkAAAAJ22M/");

    QImage::fromData(data.mid(1), "XCF");
#endif
}

QTEST_GUILESS_MAIN(TestQImage)
#include "qimage_test.moc"

Q_IMPORT_PLUGIN(ANIPlugin)
// Q_IMPORT_PLUGIN(EPSPlugin)
// Q_IMPORT_PLUGIN(HDRPlugin)
// Q_IMPORT_PLUGIN(PCXPlugin)
// Q_IMPORT_PLUGIN(PFMPlugin)
// Q_IMPORT_PLUGIN(PSDPlugin)
// Q_IMPORT_PLUGIN(PXRPlugin)
// Q_IMPORT_PLUGIN(QOIPlugin)
// Q_IMPORT_PLUGIN(RASPlugin)
// Q_IMPORT_PLUGIN(RGBPlugin)
// Q_IMPORT_PLUGIN(TGAPlugin)
Q_IMPORT_PLUGIN(XCFPlugin)
// Q_IMPORT_PLUGIN(SoftimagePICPlugin)
