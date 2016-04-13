When prime commit '&&' prime status
Then 0 '' '' $<<
.:
.prime	.prime-lock
$>>

When touch test.cx '&&' prime commit '&&' prime status
Then 0 '' '' $<<
.:
.prime	.prime-lock  test.cx
$>>

When prime commit '&&' touch test.cx '&&' prime status
Then 0 '+ ./test.cx' '' $<<
.:
.prime	.prime-lock  test.cx
$>>

When touch test.cx '&&' prime commit '&&' rm -r test.cx '&&' prime status
Then 0 '- ./test.cx' '' $<<
.:
.prime	.prime-lock
$>>

When touch test1.cx '&&' prime commit '&&' mv test1.cx test2.cx '&&' prime status
Then 0 $<<
- ./test1.cx
+ ./test2.cx
$>> '' $<<
.:
.prime	.prime-lock  test2.cx
$>>

When touch test2.cx '&&' prime commit '&&' mv test2.cx test1.cx '&&' prime status
Then 0 $<<
+ ./test1.cx
- ./test2.cx
$>> '' $<<
.:
.prime	.prime-lock  test1.cx
$>>

When touch test1.cx test2.cx '&&' prime commit '&&' mv test1.cx test3.cx '&&' prime status
Then 0 $<<
- ./test1.cx
+ ./test3.cx
$>> '' $<<
.:
.prime	.prime-lock  test2.cx  test3.cx
$>>
