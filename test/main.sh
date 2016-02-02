Q() { echo "$(TT ${CYAN}\'$@\')"; }

HELP_FULL=$<<
$(TT ${BOLD}Usage:) prime [option...]
$(TT ${BOLD}Options:)
  -? --help  Display available options
$>>

HELP_BRIEF="Try $(Q prime --help) for all available options"

ERR="$(TT ${BOLD}${RED}✖)"
INF=' '

When prime
Then 0 '' '' .:

When prime -?
Then 0 "$HELP_FULL" '' .:

When prime --help
Then 0 "$HELP_FULL" '' .:

When prime -!
Then 1 '' $<<
$ERR Unknown option $(Q -!)
$INF $HELP_BRIEF
$>> .:

When prime --?
Then 1 '' $<<
$ERR Unknown option $(Q --?)
$INF $HELP_BRIEF
$>> .:

When prime -help?
Then 1 '' $<<
$ERR Unknown option $(Q -h)
$ERR Unknown option $(Q -e)
$ERR Unknown option $(Q -l)
$ERR Unknown option $(Q -p)
$INF $HELP_BRIEF
$>> .:

When prime --unknown
Then 1 '' $<<
$ERR Unknown option $(Q --unknown)
$INF $HELP_BRIEF
$>> .:
