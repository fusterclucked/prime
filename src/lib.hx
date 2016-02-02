#pragma once

#include <embrace.h>

#define is ==

#define unless(condition) if (not (condition))

#define until(condition) while (not (condition))

#define structdef(name)
	typedef struct name name##_t
	struct name

structdef (prime_error)
	site: char*
/**/
