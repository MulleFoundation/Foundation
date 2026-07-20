### 0.23.3



* fixes NSMutableDictionary mutableCopy, no longer tries to be too smart for its own good

### 0.23.2










* **BREAKING** rename MulleObjCLoader(Foundation) category to MulleObjCDeps(Foundation); dependency-provisioning symbols now live on MulleObjCDeps
* dependency list is now pulled from generated src/reflect/objc-deps.inc (replaces objc-loader.inc)
