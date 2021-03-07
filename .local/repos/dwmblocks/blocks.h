//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		                                        /*Update Interval*/	/*Update Signal*/
	{"",            "syncstatus",                                                   0,                      15},
	{"",            "sharedrive",                                                   0,                      12},
	{"",            "corona",                                                     0,                  30},
	{"",            "forecast",                                                     18000,                  5},
	{"🌡",           "sensors | awk '/Core 0/ {print $3}'",                          5,                      4},
	{"CPU: ",       "mpstat | awk '/all/ {print $4 \"%\"}'",                        5,                      6},
	{" ",         "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,	                2},
	{"",            "battery",                                                      5,                      3},
	{"",            "volume",                                                       5,                      40},
	{"📅",         "date '+%b %d (%a) %I:%M%p'",					5,	                0},
	{"",            "internet",                                                     5,                      4},
};

// To update any element of the status bar use `pkill -RTMIN+x dwmblocks` where x is the Update Signal from above

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
