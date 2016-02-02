INCLUDES = errno iso646 stdarg stdbool stddef stdlib string

HEADERS = $(patsubst src/%.hx,.obj/%.h,$(shell find src -type f -name *.hx))
SOURCES = $(patsubst src/%.cx,.obj/%.c,$(shell find src -type f -name *.cx))

APTINSTALL = apt-get install -y \
	-o Dir::Cache::Archives=.apt/archives

.ONESHELL:
.DELETE_ON_ERROR:

.PHONY: all
all: .bin/prime

.PHONY: clean
clean:
	rm -rf .bin .obj

.obj:
	mkdir $@

.PHONY: test
test: | .obj
	lib/approve/approve
	mv *.gcda $|
	gcov $(SOURCES)
	mv *.gcov $|

.apt/archives:
	mkdir -p $@

/usr/include/lmdb.h \
/usr/lib/x86_64-linux-gnu/liblmdb.so.0: \
| .apt/archives
	$(APTINSTALL) liblmdb-dev

.obj/%.h: src/%.hx | .obj
	lib/embrace/embrace $< >$@

.obj/%.c .obj/%.h: src/%.cx | .obj
	lib/embrace/embrace $< >$@ 3>.obj/$*.h

.bin:
	mkdir $@

# _BSD_SOURCE needed for types in fts.h

.bin/prime: \
/usr/lib/x86_64-linux-gnu/liblmdb.so.0 \
/usr/include/lmdb.h \
$(HEADERS) $(SOURCES) \
| .bin
	gcc \
		-std=c11 -Werror -Wpedantic -Wall -Wextra \
		-fdiagnostics-color=auto --coverage \
		-D _BSD_SOURCE \
		$(foreach i,$(INCLUDES),-include $(i).h) \
		-I lib/embrace \
		-o $@ $(SOURCES) \
		-l:$(notdir $(word 1,$^))
	mv *.gcno .obj
