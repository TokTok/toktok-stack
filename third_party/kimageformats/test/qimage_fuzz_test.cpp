#include <QBuffer>
#include <QByteArray>
#include <QIODevice>
#include <QImage>
#include <QImageIOPlugin>
#include <QPluginLoader>

#include <cstddef>
#include <cstdint>

namespace {
void test_fromData(const uint8_t* data, size_t size)
{
    if (size == 0) {
        return;
    }

    const auto& plugins = QPluginLoader::staticInstances();
    assert(plugins.size() < 256);
    if (data[0] >= plugins.size()) {
        return;
    }

    if (auto* imagePlugin = qobject_cast<QImageIOPlugin*>(plugins[data[0]])) {
        qInstallMessageHandler([](QtMsgType, const QMessageLogContext&, const QString&) {
            // Ignore messages
        });

        QByteArray ba(reinterpret_cast<const char*>(data + 1), size - 1);
        QBuffer device(&ba);
        device.open(QIODevice::ReadOnly);

        QImage image;

        auto* handler = imagePlugin->create(&device);
        if (handler && handler->canRead()) {
            handler->read(&image);
        }
        delete handler;
    }
}
} // namespace

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size);
extern "C" int LLVMFuzzerTestOneInput(const uint8_t* data, size_t size)
{
    test_fromData(data, size);
    return 0;
}

Q_IMPORT_PLUGIN(ANIPlugin)
Q_IMPORT_PLUGIN(EPSPlugin)
Q_IMPORT_PLUGIN(HDRPlugin)
Q_IMPORT_PLUGIN(PCXPlugin)
Q_IMPORT_PLUGIN(PFMPlugin)
Q_IMPORT_PLUGIN(PSDPlugin)
Q_IMPORT_PLUGIN(PXRPlugin)
Q_IMPORT_PLUGIN(QOIPlugin)
Q_IMPORT_PLUGIN(RASPlugin)
Q_IMPORT_PLUGIN(RGBPlugin)
Q_IMPORT_PLUGIN(TGAPlugin)
Q_IMPORT_PLUGIN(XCFPlugin)
Q_IMPORT_PLUGIN(SoftimagePICPlugin)
