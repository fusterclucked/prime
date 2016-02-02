#pragma once

#define AEC(code) "\x1b[" #code "m"

#define BOLD(text) AEC (1)  text
#define RED(text)  AEC (31) text
#define CYAN(text) AEC (36) text

#define TT(text) text AEC (0)
