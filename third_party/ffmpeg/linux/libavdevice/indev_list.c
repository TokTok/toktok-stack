static const AVInputFormat * const indev_list[] = {
    &ff_alsa_demuxer,
    &ff_fbdev_demuxer,
    &ff_lavfi_demuxer,
    &ff_oss_demuxer,
    &ff_v4l2_demuxer,
    &ff_xcbgrab_demuxer,
    NULL };
