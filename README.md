# Foundation

#### 💍 MulleFoundation with improved compatibility and legacy support

It's main raison d´etre is to support `#import <Foundation/Foundation.h>`
statements in Objective-C code.


| Release Version                                       | Release Notes
|-------------------------------------------------------|--------------
| ![Mulle kybernetiK tag](https://img.shields.io/github/tag//Foundation.svg?branch=release) [![Build Status](https://github.com//Foundation/workflows/CI/badge.svg?branch=release)](//github.com//Foundation/actions)| [RELEASENOTES](RELEASENOTES.md) |





## Requirements

|   Requirement         | Release Version  | Description
|-----------------------|------------------|---------------
| [MulleFoundation](https://github.com/MulleFoundation/MulleFoundation) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag//.svg) [![Build Status](https://github.com///workflows/CI/badge.svg?branch=release)](https://github.com///actions/workflows/mulle-sde-ci.yml) | 💍 Umbrella library for the MulleFoundation
| [MulleObjCExpatFoundation](https://github.com/MulleFoundation/MulleObjCExpatFoundation) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag//.svg) [![Build Status](https://github.com///workflows/CI/badge.svg?branch=release)](https://github.com///actions/workflows/mulle-sde-ci.yml) | 👴🏼 XML parser based on MulleObjCStandardFoundation and libexpat
| [MulleObjCInetOSFoundation](https://github.com/MulleFoundation/MulleObjCInetOSFoundation) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag//.svg) [![Build Status](https://github.com///workflows/CI/badge.svg?branch=release)](https://github.com///actions/workflows/mulle-sde-ci.yml) | 📠💻 OS specific extensions to NSHost and NSURL
| [MulleObjCHTTPFoundation](https://github.com/MulleWeb/MulleObjCHTTPFoundation) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag//.svg) [![Build Status](https://github.com///workflows/CI/badge.svg?branch=release)](https://github.com///actions/workflows/mulle-sde-ci.yml) | 🎫 HTTP and HTML utility methods and classes for mulle-objc
| [mulle-objc-compat](https://github.com/mulle-objc/mulle-objc-compat) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag//.svg) [![Build Status](https://github.com///workflows/CI/badge.svg?branch=release)](https://github.com///actions/workflows/mulle-sde-ci.yml) | 🍏 Compatibility layer with Apple Objective-C runtime functions
| [objc-compat](https://github.com/MulleFoundation/objc-compat) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag//.svg) [![Build Status](https://github.com///workflows/CI/badge.svg?branch=release)](https://github.com///actions/workflows/mulle-sde-ci.yml) | 🔗 Glue for Objective-C code to support different Foundations
| [mulle-objc-list](https://github.com/mulle-objc/mulle-objc-list) | ![Mulle kybernetiK tag](https://img.shields.io/github/tag//.svg) [![Build Status](https://github.com///workflows/CI/badge.svg?branch=release)](https://github.com///actions/workflows/mulle-sde-ci.yml) | 📒 Lists mulle-objc runtime information contained in executables.

### You are here

![Overview](overview.dot.svg)

## Add

Use [mulle-sde](//github.com/mulle-sde) to add Foundation to your project:

``` sh
mulle-sde add github:MulleFoundation/Foundation
```

## Install

### Install with mulle-sde

Use [mulle-sde](//github.com/mulle-sde) to build and install Foundation and all dependencies:

``` sh
mulle-sde install --prefix /usr/local \
   https://github.com/MulleFoundation/Foundation/archive/latest.tar.gz
```

### Manual Installation

Install the requirements:

| Requirements                                 | Description
|----------------------------------------------|-----------------------
| [MulleFoundation](https://github.com/MulleFoundation/MulleFoundation)             | 💍 Umbrella library for the MulleFoundation
| [MulleObjCExpatFoundation](https://github.com/MulleFoundation/MulleObjCExpatFoundation)             | 👴🏼 XML parser based on MulleObjCStandardFoundation and libexpat
| [MulleObjCInetOSFoundation](https://github.com/MulleFoundation/MulleObjCInetOSFoundation)             | 📠💻 OS specific extensions to NSHost and NSURL
| [MulleObjCHTTPFoundation](https://github.com/MulleWeb/MulleObjCHTTPFoundation)             | 🎫 HTTP and HTML utility methods and classes for mulle-objc
| [mulle-objc-compat](https://github.com/mulle-objc/mulle-objc-compat)             | 🍏 Compatibility layer with Apple Objective-C runtime functions
| [objc-compat](https://github.com/MulleFoundation/objc-compat)             | 🔗 Glue for Objective-C code to support different Foundations
| [mulle-objc-list](https://github.com/mulle-objc/mulle-objc-list)             | 📒 Lists mulle-objc runtime information contained in executables.

Install **Foundation** into `/usr/local` with [cmake](https://cmake.org):

``` sh
cmake -B build \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DCMAKE_PREFIX_PATH=/usr/local \
      -DCMAKE_BUILD_TYPE=Release &&
cmake --build build --config Release &&
cmake --install build --config Release
```

## Author

[Nat!](https://mulle-kybernetik.com/weblog) for Mulle kybernetiK


