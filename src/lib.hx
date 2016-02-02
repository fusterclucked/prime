#pragma once

#include <embrace.h>

#define unless(condition)
	if (not (condition))

#define until(condition)
	while (not (condition))

#define try(action)
	/*console_error ("[%i] %s: %i: ENTER %s", errno, __FILE__, __LINE__, #action)*/
	if (((action), errno))
		break

#define catch(action)
	(errno = (action))

#define finally
	while (0);

#define structdef(name)
	typedef struct name name##_t
	struct name
