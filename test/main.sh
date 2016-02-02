Q() { echo "$(TT ${CYAN}\'$@\')"; }

HELP_FULL=$<<
$(TT ${BOLD}Usage:) prime [command] [option...]
$(TT ${BOLD}Commands:)
  init       Create an empty repository
$(TT ${BOLD}Options:)
  -? --help  Display usage and all available commands and options
$>>

HELP_BRIEF="Try $(Q prime --help) for all available commands and options"

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

When prime unknown
Then 1 '' $<<
$ERR Unknown command $(Q unknown)
$INF $HELP_BRIEF
$>> .:
