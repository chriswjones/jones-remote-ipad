

#define SINGLETON(classname) \
 \
static classname *shared##classname = nil; \
 \
+ (classname *)singleton { \
	@synchronized(self) { \
		if (shared##classname == nil) \
		{ \
			shared##classname = [[self alloc] init]; \
		} \
	} \
	 \
	return shared##classname; \
} \
