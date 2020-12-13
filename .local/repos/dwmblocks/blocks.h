//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		                                        /*Update Interval*/	/*Update Signal*/
	{"",            "sharedrive",                                                   0,                      12},
	{"",            "forecast",                                                     18000,                  5},
	{"",            "cputemp",                                                      10,                     1},
	{"  ",         "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,	                2},
	{"",            "battery",                                                      5,                      3},
	{"📅 ",         "date '+%b %d (%a) %I:%M%p'",					5,	                0},
	{"",            "internet",                                                     5,                      4},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
