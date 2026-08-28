# tl_xz

Telink maintained fork of [XZ Utils](https://github.com/tukaani-project/xz)
providing `liblzma`, used by the Telink Zephyr SDK
([tl_zephyr](https://github.com/telink-semi/tl_zephyr)) for compressed
filesystem support. It is pulled in through the SDK west manifests.

This repository was previously published as `telink-semi/xz` and has been
renamed to `tl_xz`, so that the Telink maintained components of the SDK are
easy to identify.

## Upstream base

This branch is based on upstream XZ Utils `master` at commit
[74c3449d8b8](https://github.com/tukaani-project/xz/commit/74c3449d8b816a724b12ebce7417e00fb597309a)
(*Tests: Improve invalid unpadded size check in test_lzma_index_append()*,
2023-08-28). The original upstream README is preserved in
[README.upstream](README.upstream).

## Telink modifications

- **Zephyr module integration** (`Telink: Add Zephyr vendor module`): adds a
  `zephyr/` directory with `CMakeLists.txt`, `Kconfig` and `config.h` that
  wrap `liblzma`, so that the library can be consumed as a Zephyr module.
- **Optimize for size by default** (`Telink: Enable Optimize for size by
  default`): compiles the library with `-Os` by default to reduce its
  footprint on embedded targets.
