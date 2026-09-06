# Foundation Library Documentation for AI
<!-- Keywords: objective-c, foundation, compatibility, umbrella, copying, runtime -->

## 1. Introduction & Purpose

**Foundation** is a mulle-objc compatibility and legacy-support layer whose main
raison d'être is to support `#import <Foundation/Foundation.h>` (and
`#import <Foundation/NS*.h>`) statements in Objective-C code written for Apple's
Foundation framework.

It solves the portability problem of classic Cocoa/Foundation code when that
code is compiled with the mulle-objc runtime. Concrete responsibilities:

- Provide an umbrella header `Foundation.h` that pulls in `MulleFoundation` and
  (when present) `MulleObjCExpatFoundation`, `MulleObjCInetOSFoundation` and
  `MulleObjCHTTPFoundation`.
- Provide dozens of Apple-compatible header shims (`NSArray.h`, `NSString.h`,
  `NSData.h`, ...) so that Apple-style subheader imports resolve without
  touching the mulle internals directly. Every shim simply does
  `#import "Foundation.h"`.
- Provide `NSMutableCopying`, a legacy copy protocol now shunned by mulle-objc
  coding, plus the C copy machinery behind it.
- Provide an empty `NSObjCRuntime.h` placeholder and an `NSDebug.h` re-export.

Foundation itself implements almost no classes; it re-exports the API surface of
its dependencies (primarily `MulleFoundation`) under Foundation-compatible
paths. It is a foundational compatibility component of the mulle-objc
ecosystem.

## 2. Key Concepts & Design Philosophy

### Apple-First Compatibility

The design goal is that unmodified Apple Foundation code compiles and runs on
mulle-objc. Code written against the mulle APIs can keep using
`#import <Foundation/Foundation.h>` instead of switching to
`#import <MulleFoundation/MulleFoundation.h>`.

### Re-Export, Not Re-Implementation

Foundation does not vendor Foundation classes. The envelope header
`Foundation.h` imports the dependency headers (`_Foundation-import.h`) and the
class-level shims (`src/headers/*.h`) all funnel back into that single envelope.
The set of actually available classes is therefore defined by what the
dependencies (notably `MulleFoundation`/`MulleObjCStandardFoundation`) provide.

### `FOUNDATION_GLOBAL` Dispatch

Public symbols are declared with the `FOUNDATION_GLOBAL` macro (`import.h`),
which maps to `MULLE_C_GLOBAL` when building the library and to
`MULLE_C_EXTERN_GLOBAL`/`extern` for consumers — keeping the library
buildable as static or dynamic without editing declarations.

### Legacy API, Explicitly Opt-In

`NSMutableCopying` is provided for legacy code only. The header itself explains
why `-mutableCopy` is discouraged: it breaks the invariant that mutable
containers can return `nil` for empty results (e.g. `[foo mutableCopy]` can
produce an object where `[array count] >= 1` would crash), whereas constructors
like `[NSMutableArray arrayWithArray:foo]` are safe. It is no longer a
"protocolclass" because putting a random `NSMutableCopying` on a subclass was
too dangerous.

## 3. Core API & Data Structures

Because this is an umbrella/compatibility layer, nearly all functionality
arrives transitively from `MulleFoundation`. The symbols defined *directly* by
this project are:

- `Foundation.h` — version info.
- `NSMutableCopying.h` — the `NSMutableCopying` protocol, `NSObject` category,
  C copy functions, and per-class conforming categories.
- `NSDebug.h` — re-export of `<MulleObjC/NSDebug.h>`.
- `NSObjCRuntime.h` — intentionally empty placeholder.
- `src/headers/*.h` — 53 Apple-compatible re-export shims.

### 3.1. `Foundation.h` (umbrella envelope header, `src/Foundation.h`)

**Purpose:** Single entry point that exposes the entire Foundation API surface
plus version information.

**Version macros / inline functions (copied verbatim):**

```c
#define FOUNDATION_VERSION  ((0UL << 20) | (23 << 8) | 4)

static inline unsigned int   Foundation_get_version_major( void)
{
   return( FOUNDATION_VERSION >> 20);
}

static inline unsigned int   Foundation_get_version_minor( void)
{
   return( (FOUNDATION_VERSION >> 8) & 0xFFF);
}

static inline unsigned int   Foundation_get_version_patch( void)
{
   return( FOUNDATION_VERSION & 0xFF);
}
```

**Exported function (declared verbatim, implemented in `Foundation.m`):**

```c
FOUNDATION_GLOBAL
uint32_t   Foundation_get_version( void);
```

- Returns the packed version number (`FOUNDATION_VERSION`, here 0.23.4).

**What `#import "Foundation.h"` pulls in:**

1. `import.h` → `_Foundation-import.h`, which imports:
   - `<MulleFoundation/MulleFoundation.h>` (required).
   - `<MulleObjCExpatFoundation/MulleObjCExpatFoundation.h>` if available
     (guarded by `__has_include`, defines `HAVE_LIB_MULLE_OBJC_EXPAT_FOUNDATION`).
   - `<MulleObjCInetOSFoundation/MulleObjCInetOSFoundation.h>` if available
     (defines `HAVE_LIB_MULLE_OBJC_INET_OS_FOUNDATION`).
   - `<MulleObjCHTTPFoundation/MulleObjCHTTPFoundation.h>` if available
     (defines `HAVE_LIB_MULLE_OBJC_HTTP_FOUNDATION`).
   - `_Foundation-include.h` (if present), which includes
     `<mulle-objc-compat/mulle-objc-compat.h>` and
     `<objc-compat/objc-compat.h>`.
2. `NSMutableCopying.h`.
3. `_Foundation-versioncheck.h` if it exists (guarded by `__has_include`).

### 3.2. `NSMutableCopying.h` (`src/NSMutableCopying.h`)

#### `@protocol NSMutableCopying`
- **Purpose:** Legacy protocol for creating a mutable copy of the receiver.
  Conceptually it implies `NSCopying` (a class should only offer `-mutableCopy`
  if it has a mutable/immutable pair).
- **Declaration (verbatim):**

```objc
@protocol NSMutableCopying  // < NSCopying>

- (id) mutableCopy;

@optional
// this is preferable as it returns autoreleased
- (id) mutableInstance;

@end
```

- `- (id) mutableCopy` — returns a mutable copy. Does *not* return
  `instancetype` (e.g. `NSSet` `-mutableCopy` returns `NSMutableSet`).
- `- (id) mutableInstance` (optional) — preferred variant; returns an
  autoreleased mutable instance.

#### `@interface NSObject( NSMutableCopying)`
- **Purpose:** Default implementation of `-mutableInstance` for every object.
- **Method (verbatim):** `- (id) mutableInstance;`
  - Implemented in `NSMutableCopying.m` as `[(id <NSMutableCopying>) self mutableCopy]`
    followed by `autorelease`.

#### Conforming categories (declarations verbatim)

These make the standard immutable collection/value classes conform so that
`-mutableCopy` and `-mutableInstance` return the matching mutable variant
(semantics shown per the implementation in `NSMutableCopying.m`):

```objc
@interface NSData( NSMutableCopying) < NSMutableCopying>
// -mutableCopy -> [[NSMutableData alloc] initWithData:self]

@interface NSString( NSMutableCopying) < NSMutableCopying>
// -mutableCopy -> [[NSMutableString alloc] initWithString:self]

@interface NSSet( NSMutableCopying) < NSMutableCopying>
// -mutableCopy -> [[NSMutableSet alloc] initWithSet:self copyItems:NO]

@interface NSArray( NSMutableCopying) < NSMutableCopying>
// -mutableCopy -> [[NSMutableArray alloc] initWithArray:self]

@interface NSDictionary( NSMutableCopying) < NSMutableCopying>
// -mutableCopy -> [[NSMutableDictionary alloc] initWithDictionary:self]

@interface NSCharacterSet( NSMutableCopying) < NSMutableCopying>
// -mutableCopy -> [[NSMutableCharacterSet new] formUnionWithCharacterSet:self]
```

Notes:
- `NSMutableString( NSMutableCopying)` also implements `-mutableCopy`
  (copies `_storage`/`_count`). The header public-conformance declarations cover
  the six immutable classes above; `NSMutableDictionary` intentionally has no
  `NSMutableCopying` conformance.
- `MulleDynamicObject( NSMutableCopying)` and `MulleObject( NSMutableCopying)`
  provide `_MulleDynamicObjectCopy` / `_MulleObjectCopy` base implementations.

#### Copy helper C functions (declarations verbatim)

```c
FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST
id   _MulleObjCInstanceCopy( id self, NSUInteger extraBytes, BOOL retainProperties);

FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST_SECOND
void   _MulleObjCInstanceRetainProperties( id clone, Class infraCls);

FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST_SECOND
id   _MulleObjCInstanceDuplicate( id object, Class infraCls, NSUInteger extraBytes);

FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST
id   _MulleDynamicObjectCopy( id object, NSUInteger extraBytes);

FOUNDATION_GLOBAL
MULLE_C_NONNULL_FIRST
id   _MulleObjectCopy( id object, NSUInteger extraBytes);
```

- `_MulleObjCInstanceCopy` — allocates an instance of `[self class]` with
  `extraBytes`, bit-copies the existing instance (`_MulleObjCInstanceDuplicate`),
  and if `retainProperties` retains all `retain`/`copy` instance-variable
  properties by walking the infraclass properties.
- `_MulleObjCInstanceRetainProperties` — walks an infraclass's properties and
  retains the receiver's ivars flagged `retain` or `copy`.
- `_MulleObjCInstanceDuplicate` — allocates a same-class instance and `memcpy`s
  `extraBytes + instanceSize` bytes from `object`.
- `_MulleDynamicObjectCopy` — duplicates a `MulleDynamicObject` including a fresh
  `__ivars` pointer map; copies (`copy`/`retain`/`strdup`) each dynamic value
  according to its generic type, then retains properties.
- `_MulleObjectCopy` — `MulleObject` base copy: dynamic-copies and replaces the
  `__lock` with a new `NSRecursiveLock`.

```c
static inline id   NSCopyObject( id object, NSUInteger extraBytes, NSZone *zone)
{
   if( ! object)
      return( nil);
   return( _MulleObjCInstanceCopy( object, extraBytes, NO));
}

static inline id   MulleDynamicObjectCopy( id object, NSUInteger extraBytes)
{
   if( ! object)
      return( nil);
   return( _MulleDynamicObjectCopy( object, extraBytes));
}

static inline id   MulleObjectCopy( id object, NSUInteger extraBytes)
{
   if( ! object)
      return( nil);
   return( _MulleObjectCopy( object, extraBytes));
}
```

- `NSCopyObject` — nil-safe shallow instance copy (the `NSZone *zone` argument
  is ignored; no property retention).
- `MulleDynamicObjectCopy` / `MulleObjectCopy` — nil-safe wrappers around the
  corresponding `_` functions.

### 3.3. `NSDebug.h` (`src/NSDebug.h`)

- **Purpose:** Debugging/introspection compatibility header.
- **Content:** A single line re-export: `#import <MulleObjC/NSDebug.h>`.
  All actual debug utilities live in the `MulleObjC` dependency.

### 3.4. `NSObjCRuntime.h` (`src/NSObjCRuntime.h`)

- **Purpose:** Compatibility placeholder.
- **Content:** Empty (header/comment only). It intentionally does nothing; the
  runtime compatibility layer comes from `<mulle-objc-compat/mulle-objc-compat.h>`
  (pulled in via `_Foundation-include.h`) and `<MulleFoundation/MulleFoundation.h>`.
  To get runtime functions/type encodings, import `MulleFoundation` directly.

### 3.5. `src/headers/*.h` (Apple-compatible shims)

53 headers exist under `src/headers/`: `NSArray.h`, `NSMutableArray.h`,
`NSDictionary.h`, `NSMutableDictionary.h`, `NSSet.h`, `NSMutableSet.h`,
`NSString.h`, `NSMutableString.h`, `NSData.h`, `NSMutableData.h`, `NSNumber.h`,
`NSValue.h`, `NSDecimal.h`, `NSDecimalNumber.h`, `NSObject.h`, `NSProxy.h`,
`NSRange.h`, `NSZone.h`, `NSEnumerator.h`, `NSCoder.h`, `NSArchiver.h`,
`NSCalendar.h`, `NSCalendarDate.h`, `NSDate.h`, `NSDateFormatter.h`,
`NSTimeZone.h`, `NSFormatter.h`, `NSNumberFormatter.h`, `NSLocale.h`,
`NSScanner.h`, `NSCharacterSet.h`, `NSMutableCharacterSet.h`,
`NSNotification.h`, `NSNotificationCenter.h`, `NSException.h`, `NSError.h`,
`NSFileManager.h`, `NSFileHandle.h`, `NSPathUtilities.h`, `NSBundle.h`,
`NSProcessInfo.h`, `NSRunLoop.h`, `NSThread.h`, `NSTask.h`, `NSTimer.h`,
`NSLock.h`, `NSUndoManager.h`, `NSUserDefaults.h`, `NSHost.h`, `NSNull.h`,
`NSByteOrder.h` and more.

- **Purpose:** Allow Apple-style subheader imports such as
  `#import <Foundation/NSArray.h>`.
- **Content:** Each shim contains exactly one line: `#import "Foundation.h"`
  (they are generated by `src/headers/generate-headers`, which iterates a class
  name list and rewrites each shim to that single import). They define no extra
  symbols; the envelope header is the true source.

## 4. Performance Characteristics

- **Public API surface:** This library adds almost no runtime overhead; it is a
  collection of include shims plus version functions. There is no per-call
  indirection introduced beyond the code actually imported from dependencies
  (`MulleFoundation`, `MulleObjC*Foundation`, `mulle-objc-compat`).
- **`-mutableCopy` variants:** O(n) in the number of elements — each
  conforming class builds a new mutable container and copies members
  (`initWithArray:`, `initWithDictionary:`, `initWithSet:copyItems:`,
  `formUnionWithCharacterSet:`). `NSString` `-mutableCopy` is O(len).
- **`_MulleObjCInstanceDuplicate`:** O(instance size) — one allocation plus one
  `memcpy` of `extraBytes + instanceSize`. `_MulleObjCInstanceCopy` with
  `retainProperties = YES` additionally walks the infraclass property list
  (O(number of `retain`/`copy` properties)).
- **`_MulleDynamicObjectCopy`:** O(n) in the number of dynamic ivars stored in
  the `__ivars` pointer map; each entry is copied according to its generic type.
- **Header import cost:** importing `Foundation.h` drags in the full dependency
  header set (compile-time cost, not runtime). The individual `src/headers/*.h`
  shims do not reduce this because they always import the envelope.
- **Thread-safety:** The library introduces no shared mutable state of its own
  (the version function is constant). Copy operations (`-mutableCopy`,
  `mutableInstance`, `MulleObjectCopy`) are *not* synchronized; copying an
  object being mutated concurrently requires external locking. Thread-safety of
  the re-exported classes is defined by `MulleFoundation`.

## 5. AI Usage Recommendations & Patterns

### Best Practices

- **Import `Foundation.h` (or the `NS*.h` shims) for Apple-compatible code.**
  For mulle-specific code you may equally import
  `<MulleFoundation/MulleFoundation.h>` directly — both land on the same classes.
- **Prefer constructors over `-mutableCopy` in new code.** The header itself
  recommends e.g. `[NSMutableArray arrayWithArray:foo]` or
  `[NSMutableString stringWithString:foo]`. `-mutableCopy` is a legacy
  convenience; `-mutableInstance` (returns autoreleased) is the safer member of
  the pair if you must use it.
- **Do not declare a random `NSMutableCopying` conformance on your own
  subclasses.** The header documents that making `-mutableCopy` part of a class
  hierarchy was "too dangerous" (a previously ignored `MulleObject -mutableCopy`
  method). Rely on the provided categories instead.
- **Check availability of specialized classes against `MulleFoundation`.**
  Since this project re-exports, the concrete class catalogue (e.g. whether
  `NSKeyedArchiver`, `NSUUID` or similar Apple-only classes exist) is
  determined by the dependencies, not by these headers.
- **Use `Foundation_get_version*()` for feature gating** — `FOUNDATION_VERSION`
  is the packed `major, minor, patch` value (0.23.4 here) and the inline
  accessors unpack it.

### Common Pitfalls

- **Do not expect `NSObjCRuntime.h` to define anything.** It is an empty
  placeholder; `NSStringFromClass`, `sel_getName` etc. come from
  `mulle-objc-compat`/`MulleFoundation`, so import those directly for runtime
  functions.
- **`-mutableCopy` can return objects where emptiness is indistinguishable**
  **from nil-returning factories.** Code like
  `array = [foo mutableCopy]; [array addObject:@"bar"];` can crash for empty
  sources where `arrayWithArray:` wouldn't.
- **`-mutableCopy` is not `instancetype`.** The returned class differs from the
  receiver (e.g. `NSString` -> `NSMutableString`, `NSSet` -> `NSMutableSet`),
  so declare the target type explicitly.
- **`NSZone *zone` in `NSCopyObject` is ignored.** Do not rely on zone-based
  allocation semantics.
- **The `_`-prefixed copy functions are internal machinery** (`_MulleObjC*`).
  Use the `FOUNDATION_GLOBAL`-exposed wrappers `MulleObjectCopy`,
  `MulleDynamicObjectCopy` or inline `NSCopyObject` from application code.
- **`src/headers/*.h` are generated** by `src/headers/generate-headers`; edit
  that script, not the shims, if you need to add a class name (then run it).

### Idiomatic Usage

- `#import <Foundation/Foundation.h>` as the single import for classic Cocoa
  style code compiled with mulle-objc.
- `mutableInstance` (autoreleased, from the `NSObject` category) when a
  temporary mutable working copy is needed.
- Struct-copy style in C code via `_MulleObjCInstanceDuplicate` (deep-copying
  object graphs yourself), or `NSCopyObject` for a shallow copy.

## 6. Integration Examples

### Example 1: Umbrella import and version check

```objc
#import <Foundation/Foundation.h>
#import <stdio.h>

int   main( int argc, char *argv[])
{
   fprintf( stderr, "Foundation 0.%d.%d (packed %08lx)\n",
            (int) Foundation_get_version_minor(),
            (int) Foundation_get_version_patch(),
            (long) Foundation_get_version());
   return( 0);
}
```

### Example 2: MutableCopying on NSArray (from `test/20_mutablecopy/nsarray.m`)

```objc
#import <Foundation/Foundation.h>

@interface NSArray (Forward)
- (id) mutableInstance;
@end

int   main( int argc, const char * argv[])
{
   id         array;
   NSNumber   *nr;
   NSString   *key;
   id         copied;

   nr     = [NSNumber numberWithInt:1848];
   key    = [NSString stringWithUTF8String:"bar"];
   array  = [NSArray arrayWithObjects:nr, key, nil];
   copied = [array mutableInstance];
   return( [copied count] == 2 ? 0 : -1);
}
```

### Example 3: MutableCopying on NSMutableCharacterSet

```objc
#import <Foundation/Foundation.h>

@interface NSMutableCharacterSet (Forward)
- (id) mutableInstance;
@end

int   main( int argc, char *argv[])
{
   NSMutableCharacterSet   *obj;
   id                      value;

   obj   = [NSMutableCharacterSet characterSetWithCharactersInString:@"a"];
   value = [obj mutableInstance];
   if( ! value)
      return( -1);
   return( 0);
}
```

### Example 4: Apple-compatible subheader import via shim

```objc
// old Apple style -- works here too, every shim maps back to Foundation.h
#import <Foundation/Foundation.h>
#import <Foundation/NSArray.h>
#import <Foundation/NSString.h>

int   main( int argc, char *argv[])
{
   NSArray   *array;

   array = [NSArray arrayWithObject:@"hello"];   // re-exported through the shim
   return( [array count] == 1 ? 0 : -1);
}
```

Note: test programs in `test/20_mutablecopy` are actually compiled against
`<MulleObjCStandardFoundation/MulleObjCStandardFoundation.h>` (with Apple's
`<Foundation/Foundation.h>` as the fallback in `nsmutablecharacterset.m` when
`__MULLE_OBJC__` is not defined) — a demonstration that both import paths reach
the same classes.

## 7. Dependencies

Direct `mulle-sde` library dependencies (from `.mulle/etc/sourcetree/config`
and `clib.json`):

- `MulleFoundation` — required; provides the actual Foundation class catalogue.
- `MulleObjCExpatFoundation` — optional XML parser support (imported when
  installed, defines `HAVE_LIB_MULLE_OBJC_EXPAT_FOUNDATION`).
- `MulleObjCInetOSFoundation` — OS-specific `NSHost`/`NSURL` extensions
  (`HAVE_LIB_MULLE_OBJC_INET_OS_FOUNDATION`).
- `MulleObjCHTTPFoundation` — HTTP/HTML utility methods/classes
  (`HAVE_LIB_MULLE_OBJC_HTTP_FOUNDATION`).
- `mulle-objc-compat` — Apple Objective-C runtime compatibility layer
  (`<mulle-objc-compat/mulle-objc-compat.h>`).
- `objc-compat` — glue for Objective-C code to support different Foundations
  (`<objc-compat/objc-compat.h>`; no-link).
- `mulle-objc-list` — build-time runtime-info listing tool (no-header,
  no-import, no-link).

Foundationally, this is the compatibility layer in front of the
`MulleFoundation` umbrella (`MulleObjCStandardFoundation` and friends).