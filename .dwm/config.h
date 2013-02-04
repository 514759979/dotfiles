#include <X11/XF86keysym.h>

void my_restart(const Arg *arg)
{
    execlp("dwm", "dwm", NULL);
}

/* appearance */
static const char font[]            = "YaHei Consolas Hybrid:pixelsize=14";
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#222222";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#005577";
static const char selbgcolor[]      = "#005577";
static const char selfgcolor[]      = "#eeeeee";
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int snap      = 10;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5"};

static const Rule rules[] = {
    /* class          instance    title       tags mask    isfloating   monitor */
    { "Chromium",     NULL,       NULL,       1,           False,       -1 },
    { "Firefox",      NULL,       NULL,       1,           False,       -1 },
    { "Dia",          NULL,       NULL,       8,           True,        -1 },
    { "MPlayer",      NULL,       NULL,       0,           True,        -1 },
    { "Qmmp",         NULL,       NULL,       8,           True,        -1 },
    { "Thunderbird",  NULL,       NULL,       2,           False,       -1 },
    { "VirtualBox",   NULL,       NULL,       4,           False,       -1 },
    { "XTerm",        NULL,       NULL,       1,           False,       -1 },
    { "Yad",          NULL,       NULL,       0,           True,        -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[M]",      monocle },
    { "[]=",      tile },    /* first entry is default */
    { "><>",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

#define SHCMD(cmd) {.v = (const char*[]) {"/bin/sh", "-c", cmd, NULL} }
#define CMD(cmd)   {.v = (const char*[]) {cmd, NULL} }

static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_e,      spawn,          CMD("xterm") },
    { MODKEY,                       XK_f,      spawn,          CMD("firefox") },
    { MODKEY,                       XK_r,      spawn,          SHCMD("xterm -e osily") },
    { MODKEY,                       XK_q,      spawn,          SHCMD("xterm -e osily 1") },
/*
    { ControlMask,                  XK_comma,  spawn,          SHCMD("m_con p") },
    { ControlMask,                  XK_period, spawn,          SHCMD("m_con pt_step 1") },
    { ControlMask,                  XK_slash,  spawn,          SHCMD("m_con pt_step -1") },
    { ControlMask,                  XK_Left,   spawn,          SHCMD("m_con seek -10") },
    { ControlMask,                  XK_Right,  spawn,          SHCMD("m_con seek +10") },
    { ControlMask,                  XK_Up,     spawn,          SHCMD("m_con seek +60") },
    { ControlMask,                  XK_Down,   spawn,          SHCMD("m_con seek -60") },
    { ControlMask,              XK_semicolon,  spawn,          SHCMD("m_con stop") },
*/
    { ControlMask,                  XK_comma,  spawn,          SHCMD("qmmp -t") },
    { ControlMask,                  XK_period, spawn,          SHCMD("qmmp --next") },
    { ControlMask,                  XK_slash,  spawn,          SHCMD("qmmp --previous") },
    { ControlMask,                  XK_Left,   spawn,          SHCMD("qmmp --seek-bwd 10") },
    { ControlMask,                  XK_Right,  spawn,          SHCMD("qmmp --seek-fwd 10") },
    { ControlMask,                  XK_Up,     spawn,          SHCMD("qmmp --seek-fwd 60") },
    { ControlMask,                  XK_Down,   spawn,          SHCMD("qmmp --seek-bwd 60") },
    { MODKEY,                       XK_w,      spawn,          CMD("word") },
    { MODKEY,                       XK_a,      spawn,          CMD("screen_big.sh") },
    { MODKEY,                       XK_z,      spawn,          CMD("screen_small.sh") },
    { MODKEY,                       XK_m,      spawn,          SHCMD("xset dpms force off;slock") },
    { MODKEY,                       XK_n,      spawn,          SHCMD("xset dpms force off") },
    { MODKEY,                       XK_c,      spawn,          SHCMD("tmux save-buffer -|xclip -selection clipboard;tmux save-buffer -|xclip -selection primary") },
    { 0,                            XK_Print,  spawn,          CMD("scrot") },
    { Mod1Mask,                     XK_Print,  spawn,          SHCMD("sleep 0.5;scrot -s") },
    { 0,            XF86XK_AudioMute,          spawn,          SHCMD("amixer sset Master toggle") },
    { 0,            XF86XK_AudioRaiseVolume,   spawn,          SHCMD("amixer sset Master 1+") },
    { 0,            XF86XK_AudioLowerVolume,   spawn,          SHCMD("amixer sset Master 1-") },
    { MODKEY|ShiftMask,             XK_r,      my_restart,     {0} },
    { MODKEY,                       XK_semicolon,      view,   {.ui = 0} },
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
    { Mod1Mask,                     XK_Tab,    focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
    { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
    { MODKEY,                       XK_Return, zoom,           {0} },
    { MODKEY,                       XK_Tab,    view,           {0} },
    { Mod1Mask,                     XK_F4,     killclient,     {0} },
    { MODKEY,                       XK_i,      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_o,      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_p,      setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_space,  setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
    { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
    { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)
    TAGKEYS(                        XK_9,                      8)
    { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
