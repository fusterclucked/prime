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

// TODO not needed once prime_db is fully encapsulated
#include <lmdb.h>

structdef (prime_db)
	env: MDB_env*
	txn: MDB_txn*
	dbi: MDB_dbi
/**/
