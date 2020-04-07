# Foundation

💍 MulleFoundation with improved compatibility and legacy support

It's raison d´etre is to support `#import <Foundation/Foundation.h>`
statements in Objective-C code.

It also adds the following libraries to the list of dependencies:


Library                                                                            | Description
-----------------------------------------------------------------------------------|---------------------
[MulleObjCExpatFoundation](//github.com/MulleFoundation/MulleObjCExpatFoundation)  | XML property lists
[MulleObjCInetFoundation](//github.com/MulleFoundation/objc-compat)                | NSURL and NSHost
[MulleObjCInetOSFoundation](//github.com/MulleFoundation/objc-compat)              | NSURL file handling
[objc-compat](//github.com/MulleFoundation/objc-compat)                            | Apple runtime compatibility


####  Legacy technologies

* File handling with NSURL
* XML


Otherwise in content **Foundation** is identical to *MulleFoundation*. See the
[MulleFoundation](//github.com/MulleFoundation/MulleFoundation)
for more information.


Build Status | Release Version
-------------|-----------------------------------
[![Build Status](https://travis-ci.org/MulleFoundation/Foundation.svg)](https://travis-ci.org/MulleFoundation/Foundation) | ![Community tag](https://img.shields.io/github/tag/MulleFoundation/Foundation.svg)


## Install

See [foundation-developer](//github.com/MulleFoundation/foundation-developer)
for instructions how to install via *apt* or *brew* or via an
installer script. There is also a "Dockerfile" available. It will install
everything you need.

### Legacy install

```
mulle-sde install --standalone \
                  --prefix "/usr/local" \
                  "https://github.com/MulleFoundation/Foundation/archive/latest.tar.gz"
```

#### Legacy install prerelease

For testing before release:

```
source `curl -L https://raw.githubusercontent.com/MulleFoundation/Foundation/prerelease/.mulle/etc/env/environment-host-travis-ci-prerelease.sh`
mulle-sde install --standalone \
                  --branch prerelease \
                  --prefix "/tmp/usr" \
                  "https://github.com/MulleFoundation/Foundation.git"
```

## Author

[Nat!](//www.mulle-kybernetik.com/weblog) for
[Mulle kybernetiK](//www.mulle-kybernetik.com) and
[Codeon GmbH](//www.codeon.de)
