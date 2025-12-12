# Foundation Library Documentation for AI

## 1. Introduction & Purpose

**Foundation** is a compatibility layer and wrapper around **MulleFoundation** that enables standard Objective-C code to use `#import <Foundation/Foundation.h>` statements while providing additional Apple Objective-C runtime compatibility features.

The primary purpose is:
- Support legacy code written for Apple's Foundation framework that uses `#import <Foundation/Foundation.h>`
- Provide compatibility protocols and classes (NSMutableCopying, NSDebug utilities)
- Bridge mulle-objc runtime functions with standard Apple Objective-C conventions
- Enable code portability between Apple's Cocoa and mulle-sde ecosystems

This library is essentially a thin wrapper that re-exports **MulleFoundation** while adding a few compatibility/legacy constructs.

## 2. Key Concepts & Design Philosophy

### Compatibility Wrapper
Foundation acts as a compatibility layer between two Objective-C ecosystems:
- **Standard target**: Code written for Apple Foundation using `#import <Foundation/Foundation.h>`
- **Bridge mechanism**: Re-export MulleFoundation classes through Foundation-compatible header paths
- **Interoperability**: Translate between Apple and mulle-objc runtime conventions where needed

### Legacy Protocol Support
Includes several protocols and classes that were common in earlier Objective-C practices:
- `NSMutableCopying` - Legacy copying protocol (now generally avoided in modern mulle-objc)
- `NSDebug` - Debugging utilities
- ObjC runtime compatibility wrappers

### Re-export Strategy
Foundation does not implement classes directly. Instead:
1. Imports all classes from **MulleFoundation**
2. Re-exports them with Apple-compatible header paths
3. Adds thin wrapper protocols/utilities for compatibility
4. Maintains binary compatibility with MulleFoundation

---

## 3. Core API & Data Structures

### 3.1 Main Import Header

#### `<Foundation/Foundation.h>` (Primary Import)

**Purpose**: Apple-compatible Foundation import that provides all standard Foundation classes.

**Re-exported Classes**: All classes from MulleFoundation are available:
- Value types: NSNumber, NSString, NSData, NSValue, NSNull
- Collections: NSArray, NSDictionary, NSSet (mutable variants available)
- Time: NSDate, NSTimeZone, NSCalendar, NSDateComponents
- Formatting: NSDateFormatter, NSNumberFormatter, NSScanner, NSLocale
- Exceptions: NSException, NSError, NSAssertionHandler
- Utilities: NSCharacterSet, NSUndoManager, NSNotificationCenter, NSUUID, NSDecimalNumber
- Serialization: NSCoder, NSKeyedArchiver, NSPropertyListSerialization
- OS/Platform: NSTask, NSPipe, NSFileManager, NSBundle, NSProcessInfo
- Regex: NSRegularExpression
- And many more...

**Usage**:
```objc
#import <Foundation/Foundation.h>

// All standard Foundation classes immediately available
NSString *str = @"Hello";
NSArray *arr = @[@1, @2, @3];
NSDictionary *dict = @{@"key": @"value"};
```

### 3.2 Compatibility Protocols

#### `NSMutableCopying` Protocol

**Purpose**: Legacy protocol for objects that support mutable copying (deprecated in modern Objective-C).

**Declaration**:
```objc
@protocol NSMutableCopying
- (id) mutableCopyWithZone:(NSZone *)zone;
@end
```

**Methods**:
- `- (id) mutableCopyWithZone:(NSZone *)zone` - Create a mutable copy of the receiver

**Note**: This protocol is included for compatibility with legacy code. Modern mulle-objc code should avoid it. Most Foundation classes prefer explicit class methods (e.g., `[NSMutableArray arrayWithArray:original]`).

**When Used**: 
- Old code that called `-mutableCopy` on objects
- Rarely needed in new mulle-objc development

### 3.3 Debugging Utilities

#### `NSDebug.h` (Debugging Support)

**Purpose**: Provides debugging and introspection utilities compatible with Apple Foundation.

**Typical Utilities** (exact exports depend on build):
- Memory management tracing
- Object lifecycle inspection
- Debug logging utilities
- Assertion handling

**Note**: Most of these are optional/conditional on debug builds and should not be relied upon in production code.

### 3.4 Objective-C Runtime Compatibility

#### `NSObjCRuntime.h` & `mulle-objc-compat` Integration

**Purpose**: Bridge between mulle-objc runtime conventions and Apple Objective-C conventions.

**Provides**:
- Standard Apple runtime function wrappers (e.g., `sel_getName`, `class_getName`)
- Type encoding utilities
- Method introspection functions
- Protocol manipulation functions

**Examples**:
- `NSStringFromClass()` - Get class name as NSString
- `NSClassFromString()` - Get class from name string
- `NSStringFromSelector()` / `NSSelectorFromString()` - Selector/string conversion

**Note**: These are thin wrappers. Direct use of mulle-objc runtime functions is preferred in mulle-sde code.

---

## 4. Performance Characteristics

### Startup & Memory
- **Initialization**: Inherited from MulleFoundation (~100ms)
- **Binary size overhead**: Minimal (~10KB) over MulleFoundation due to thin wrapper
- **Runtime footprint**: Identical to MulleFoundation (~50-100MB typical)

### Header Import Overhead
- `#import <Foundation/Foundation.h>` resolves to MulleFoundation re-export
- Compilation time: Negligible difference from importing MulleFoundation directly

### Class Lookup
- All class/method lookups delegate to MulleFoundation
- Performance characteristics identical to direct MulleFoundation usage

---

## 5. AI Usage Recommendations & Patterns

### Best Practices

**Use for Legacy/Portable Code:**
- When porting Apple Foundation code to mulle-sde
- When writing code that might target multiple Objective-C implementations
- For educational purposes (teaching standard Objective-C)

**Prefer MulleFoundation in New Code:**
- New mulle-sde code should import `<MulleFoundation/MulleFoundation.h>` directly
- This makes it clear the code is mulle-specific
- Avoids confusion about which Foundation is being used

**Compatibility Import Pattern:**
```objc
// For portable code
#import <Foundation/Foundation.h>

// For mulle-specific code (preferred)
#import <MulleFoundation/MulleFoundation.h>
```

**Avoid Legacy Protocols:**
- Don't use NSMutableCopying in new mulle-objc code
- Use explicit class methods or factory functions instead
- NSMutableCopying is provided only for compatibility

### Common Pitfalls

**Mixing Imports:**
- Don't mix `#import <Foundation/...>` and `#import <MulleFoundation/...>`
- Pick one and stick with it in a codebase
- Both refer to same classes but create confusion

**Assuming Apple Compatibility:**
- Just because code imports `<Foundation/Foundation.h>` doesn't mean it runs on macOS
- mulle-sde provides the Foundation interface but not Apple runtime compatibility
- Threading models, memory management differ from Apple Cocoa

**Relying on NSMutableCopying:**
- Code using NSMutableCopying won't work across all implementations
- Better to use explicit mutable copy methods available in mulle-objc
- Protocol is provided for compatibility only

**Runtime Function Confusion:**
- mulle-objc runtime functions have different names/signatures from Apple
- Foundation wrappers provide compatibility layer but aren't perfect translations
- For deep runtime manipulation, prefer mulle-objc functions directly

### Idiomatic Usage Patterns

**Pattern 1: Legacy Code Import**
```objc
// Old code that was written for Apple Foundation
#import <Foundation/Foundation.h>

int main(void) {
    @autoreleasepool {
        NSString *msg = @"This code works on both Apple and mulle-sde!";
        NSLog(@"%@", msg);
        return 0;
    }
}
```

**Pattern 2: Compatibility Function Usage**
```objc
// Using compatibility runtime functions
Class stringClass = NSClassFromString(@"NSString");
SEL selector = NSSelectorFromString(@"stringWithFormat:");

if (stringClass && selector) {
    // Dynamic method call using compatibility layer
}
```

**Pattern 3: Gradual Migration to mulle-sde**
```objc
// Start with Foundation for compatibility
#import <Foundation/Foundation.h>

// As code matures, migrate to:
#import <MulleFoundation/MulleFoundation.h>

// This makes the transition explicit and intentional
```

---

## 6. Integration Examples

### Example 1: Legacy Application Using Standard Import

```objc
#import <Foundation/Foundation.h>

// This code would work on both Apple and mulle-sde
int main(int argc, char *argv[]) {
    @autoreleasepool {
        NSArray *arguments = [NSArray arrayWithObjects:argv + 1 count:argc - 1];
        NSLog(@"Program arguments: %@", arguments);
        
        NSDictionary *env = [[NSProcessInfo processInfo] environment];
        NSString *user = [env objectForKey:@"USER"];
        NSLog(@"Running as: %@", user);
        
        return 0;
    }
}
```

### Example 2: Cross-Platform Compatibility Layer

```objc
#import <Foundation/Foundation.h>

// Generic code that works with standard Objective-C
@interface DataProcessor : NSObject
- (NSString *)processArray:(NSArray *)items;
@end

@implementation DataProcessor
- (NSString *)processArray:(NSArray *)items {
    NSMutableString *result = [NSMutableString string];
    for (id item in items) {
        [result appendString:[NSString stringWithFormat:@"%@, ", item]];
    }
    return result;
}
@end
```

### Example 3: Using Compatibility Runtime Functions

```objc
#import <Foundation/Foundation.h>

int main(void) {
    @autoreleasepool {
        // Convert between strings and class/selector representations
        Class cls = NSClassFromString(@"NSArray");
        SEL selector = NSSelectorFromString(@"arrayWithObject:");
        
        if (cls && selector) {
            NSLog(@"Class: %@", NSStringFromClass(cls));
            NSLog(@"Selector: %@", NSStringFromSelector(selector));
        }
        
        return 0;
    }
}
```

### Example 4: Debugging with NSDebug Utilities

```objc
#import <Foundation/Foundation.h>

int main(void) {
    @autoreleasepool {
        // Create and inspect object
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObject:@"test"];
        
        // Debug introspection (exact API depends on build)
        NSLog(@"Array contents: %@", arr);
        NSLog(@"Array class: %@", [arr class]);
        
        return 0;
    }
}
```

---

## 7. Dependencies

**Foundation** has minimal direct dependencies. It acts as a wrapper/compatibility layer:

### Core Dependencies
- **MulleFoundation** - All actual functionality
- **mulle-objc-compat** - Objective-C runtime compatibility layer
- **objc-compat** - Objective-C code glue

### Transitive Dependencies
Through MulleFoundation, includes all components documented in the MulleFoundation TOC:
- MulleObjC runtime
- All value types, collections, time, formatting, serialization components
- All utility and specialized classes

### Purpose of Foundation
Foundation exists solely to:
1. Provide `#import <Foundation/Foundation.h>` compatibility
2. Re-export MulleFoundation classes
3. Bridge to Apple Objective-C conventions where needed
4. Support legacy code patterns

For new mulle-sde development, import **MulleFoundation** directly and skip this wrapper.
