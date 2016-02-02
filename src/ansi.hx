#pragma once

#define AEC(code) "\x1b[" #code "m"

#define BOLD AEC(1)
#define RED  AEC(31)
#define BLUE AEC(34)
#define CYAN AEC(36)

#define TT(text) text AEC(0)
