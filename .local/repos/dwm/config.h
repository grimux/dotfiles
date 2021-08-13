/*
	DWM config
	Jacob Meredith
*/

/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const unsigned int gappx     = 12;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Inconsolata Nerd Font:size=10", "JoyPixels:pixelsize=10:antialias=true:autohint=true" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_1[]	    = "#282c34"; // background color of bar
static const char col_2[]	    = "#282c34"; // border color unfocused windows
static const char col_3[]	    = "#d7d7d7"; //
static const char col_purple[]	    = "#bd93f9"; // border color focused windows and tags
static const char col_red[]	    = "#ff5555";
static const unsigned int baralpha = 0xee;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_3, col_1, col_2 },
	[SchemeSel]  = { col_1, col_purple,  col_red },
};
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { " dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx " };
//static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//static const char *tags[] = { "", "", "", "", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class           instance    title       tags mask     switchtotag     isfloating   monitor */
	//{ "Gimp",        NULL,       NULL,       0,            0,              1,           -1 },
	{ "Brave",         "brave",    NULL,       1 << 1,       1,              0,           -1 },
	{ "Pcmanfm",       "pcmanfm",  NULL,       1 << 2,       1,              0,           -1 },
	{ "Notepadqq",     NULL,       NULL,       1 << 3,       1,              0,           -1 },
	//{ "Brave",       NULL,       NULL,       1 << 4,       0,              0,           -1 },
	{ "Signal",        NULL,       NULL,       1 << 5,       1,              0,           -1 },
	{ "Deadbeef",      NULL,       NULL,       1 << 6,       1,              0,           -1 },
	//{ "deadbeef",    NULL,       NULL,       1 << 7,       1,              0,           -1 },
	{ "Syncthing GTK", NULL,       NULL,       1 << 8,       0,              0,           -1 },
	{ "Lutris",        NULL,       NULL,       1 << 8,       1,              0,           -1 },
};

/* layout(s) */
#include "layouts.c"
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      grid },
	{ NULL,       NULL },
};

#include <X11/XF86keysym.h>
/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]     = { "dmenu_run", "-p", "Run:", NULL };
static const char *sudodmenucmd[] = { "sudo", "dmenu_run", "-p", "sudo:", NULL };
static const char *termcmd[]      = { "st", NULL };
static const char *filemgr[]      = { "pcmanfm", NULL };
static const char *termfilemgr[]  = { "st", "-e", "ranger", NULL };
static const char *browser[]      = { "brave", NULL };
static const char *music[]        = { "deadbeef", NULL};
static const char *upvol[]        = { "pamixer", "-i", "5", ";", "pkill", "-RTMIN+40", "dwmblocks", NULL};
static const char *downvol[]      = { "pamixer", "-d", "5", ";", "pkill", "-RTMIN+40", "dwmblocks", NULL};
static const char *mutevol[]      = { "pamixer", "-t", "pkill", "-RTMIN+40", "dwmblocks", NULL};
static const char *mustog[]       = { "deadbeef", "--toggle-pause", NULL};
static const char *musnext[]      = { "deadbeef", "--next", NULL};
static const char *musprev[]      = { "deadbeef", "--prev", NULL};
static const char *musstop[]      = { "deadbeef", "--stop", NULL};

/* Hotkeys */
// ----------------------------------------------------------------------------------------------------------------------------
static Key keys[] = {
	/* modifier            key            function        argument */
	{ MODKEY,              XK_b,          togglebar,      {0} },
	{ MODKEY,              XK_f,          togglefullscr,  {0} },
	{ MODKEY,              XK_f,          togglebar,      {0} },
	{ MODKEY,              XK_h,          setmfact,       {.f = -0.05} },
	{ MODKEY,              XK_j,          focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,    XK_j,          rotatestack,    {.i = +1 } },
	{ MODKEY,              XK_k,          focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,    XK_k,          rotatestack,    {.i = -1 } },
	{ MODKEY,              XK_l,          setmfact,       {.f = +0.05} },
	{ MODKEY,              XK_o,          incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,    XK_o,          incnmaster,     {.i = -1 } },
	{ MODKEY,              XK_q,          killclient,     {0} },
	//{ MODKEY|ShiftMask,    XK_r,          spawn,          SHCMD("pkill dwm && setsid -f dwm") },
	{ MODKEY,              XK_w,          spawn,          {.v = browser } },
	{ MODKEY,              XK_grave,      spawn,          SHCMD("dmenuunicode") },
	{ MODKEY,	       XK_Return,     spawn,          {.v = termcmd }  },
	{ MODKEY,              XK_space,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,    XK_space,      spawn,          {.v = sudodmenucmd } },
	{ MODKEY,              XK_semicolon,  setmfact,       {.f = +0.05} },
	//{ MODKEY,              XK_space,      zoom,           {0} },
	//{ MODKEY,              XK_minus,      spawn,          SHCMD("pamixer --allow-boost -d 5; pkill -RTMIN+40 dwmblocks") },
	//{ MODKEY|ShiftMask,    XK_minus,      spawn,          SHCMD("pamixer --allow-boost -d 15; pkill -RTMIN+40 dwmblocks") },
	//{ MODKEY,              XK_equal,      spawn,          SHCMD("pamixer --allow-boost -i 5; pkill -RTMIN+40 dwmblocks") },
	//{ MODKEY|ShiftMask,    XK_equal,      spawn,          SHCMD("pamixer --allow-boost -i 15; pkill -RTMIN+40 dwmblocks") },
	// ----------------------------------------------------------------------------------------------------------------------------
	

	// Program launching
	// ----------------------------------------------------------------------------------------------------------------------------
	{ MODKEY,              XK_e,          spawn,          {.v = filemgr } },
	{ MODKEY,              XK_r,          spawn,          {.v = termfilemgr } },
	{ MODKEY,              XK_m,          spawn,          {.v = music } },
	{ MODKEY,              XK_g,          spawn,          SHCMD("lutris") },
	{ MODKEY,              XK_F7,         spawn,          SHCMD("toggle-alpha") },			// toggle alpha
	{ MODKEY,              XK_F5,         spawn,          SHCMD("xow-toggle") },
	{ MODKEY,              XK_n,          spawn,          SHCMD("st -e nvim -c VimwikiIndex") },	// Launch vimwiki
	{ MODKEY|ShiftMask,    XK_Return,     spawn,          {.v = filemgr }  }, 
	{ MODKEY|ShiftMask,    XK_p,          spawn,          SHCMD("passmenu") },
	{ MODKEY|ShiftMask,    XK_s,          spawn,          SHCMD("synctoggle") },			// syncthing-gtk
	{ MODKEY,              XK_F1,         spawn,          SHCMD("groff -mom /usr/local/share/dwm/jman.mom -Tpdf | zathura -") },
	{ MODKEY|ShiftMask,    XK_n,          spawn,          SHCMD("notepadqq") },
	// ----------------------------------------------------------------------------------------------------------------------------
	
	
	// Media Keys
	// ----------------------------------------------------------------------------------------------------------------------------
	{ 0,                   XF86XK_AudioLowerVolume, spawn, {.v = downvol } },
	{ 0,                   XF86XK_AudioMute,        spawn, {.v = mutevol } },
	{ 0,                   XF86XK_AudioRaiseVolume, spawn, {.v = upvol   } },
	{ 0,                   XF86XK_AudioPlay,        spawn, {.v = mustog  } },
	{ 0,                   XF86XK_AudioNext,        spawn, {.v = musnext } },
	{ 0,                   XF86XK_AudioPrev,        spawn, {.v = musprev } },
	{ 0,                   XF86XK_AudioStop,        spawn, {.v = musstop } },
	// ----------------------------------------------------------------------------------------------------------------------------

	// Layout manipulation
	{ MODKEY,              XK_Tab,        cyclelayout,      {.i = +1 } },
	//{ MODKEY|ControlMask,  XK_f,          cyclelayout,      {.i = -1 } },
	//{ MODKEY,              XK_space,      setlayout,        {0} },
	//{ MODKEY|ShiftMask,    XK_space,      togglefloating,   {0} },
	{ MODKEY,              XK_0,          view,             {.ui = ~0 } },
	{ MODKEY|ShiftMask,    XK_0,          tag,              {.ui = ~0 } },

	// Switching to specific layouts
	//{ MODKEY,              XK_t,          setlayout,      {.v = &layouts[0]} },
	//{ MODKEY|ShiftMask,    XK_f,          setlayout,      {.v = &layouts[1]} },
	//{ MODKEY,              XK_m,          setlayout,      {.v = &layouts[2]} },
	//{ MODKEY,              XK_g,          setlayout,      {.v = &layouts[3]} },

	//{ MODKEY,              XK_comma,      focusmon,       {.i = -1 } },
	//{ MODKEY,              XK_period,     focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,      XK_comma,      tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,      XK_period,     tagmon,         {.i = +1 } },
	{ MODKEY,                XK_minus,      setgaps,        {.i = -4 } },
	{ MODKEY,                XK_equal,      setgaps,        {.i = +4 } },
	{ MODKEY|ShiftMask,      XK_minus,      setgaps,        {.i = 0  } },
	{ MODKEY|ShiftMask,      XK_equal,      setgaps,        {.i = -1 } },
	//{ MODKEY|ShiftMask,    XK_x,          quit,           {0} },

	// Switching between monitors
	

	// Workspaces
	TAGKEYS(               XK_1,                      0)
	TAGKEYS(               XK_2,                      1)
	TAGKEYS(               XK_3,                      2)
	TAGKEYS(               XK_4,                      3)
	TAGKEYS(               XK_5,                      4)
	TAGKEYS(               XK_6,                      5)
	TAGKEYS(               XK_7,                      6)
	TAGKEYS(               XK_8,                      7)
	TAGKEYS(               XK_9,                      8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        cyclelayout,    {.i = +1} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
