This is a recommended set of flags for bazel builds on various platforms.
Import the appropriate presets into your ~/.bazelrc. Recommended ~/.bazelrc
for Clang on Linux:

```sh
build --jobs=12

import %workspace%/tools/bazelrc/linux-clang
```

Change the value of `--jobs` to something your system can handle. Note that
this only influences the bazel scheduler. Under load, fewer actions may
actually be executing at any given time.

Choose a different preset for e.g. FreeBSD or GCC. You can also combine the
configs from the `config` directory yourself if no preset suits you.
