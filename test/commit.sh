When prime commit '&&' prime ls
Then 0 '' '' $<<
.:
.prime	.prime-lock
$>>

When mkdir src '&&' touch src/test.cx '&&' prime commit '&&' prime ls
Then 0 ./src/test.cx '' $<<
.:
.prime	.prime-lock  src/

./src:
test.cx
$>>
