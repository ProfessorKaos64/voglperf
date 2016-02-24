- [x] debian/changelog is not of the correct format; You should probably use:
dch --create -v 1.0 --package voglperf

- [ ] steamos-dev probably shouldn't be added as dependency. Since this I want to be able to build this in any ubuntu, debian and steam-os without modification.

- [ ] There needs to be changes to the CMakeLists.txt (so that you use system packages instead of the ones that are in the repository).

- [ ] Due to a bug in Ubuntu dev library location the build_options.cmake (causes a linking issue when trying to build the i386 library); In addition the build dependencies listed are not complete for both i386 and amd64 builds. [So this will not build on my Ubuntu 15.10 amd64 machine]
