INCLUDES = stdarg stdbool stdlib

HEADERS = $(patsubst src/%.hx,.obj/%.h,$(shell find src -type f -name *.hx))
SOURCES = $(patsubst src/%.cx,.obj/%.c,$(shell find src -type f -name *.cx))

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

.obj/%.h: src/%.hx | .obj
	lib/embrace/embrace $< >$@

.obj/%.c .obj/%.h: src/%.cx | .obj
	lib/embrace/embrace $< >$@ 3>.obj/$*.h

.bin:
	mkdir $@

.bin/prime: $(HEADERS) $(SOURCES) | .bin
	gcc \
		-std=c11 -Werror -Wpedantic -Wall -Wextra \
		-fdiagnostics-color=auto --coverage \
		$(foreach i,$(INCLUDES),-include $(i).h) \
		-I lib/embrace \
		-o $@ $(SOURCES)
	mv *.gcno .obj
