#if defined _catch_const_included
	#endinput
#endif
#define _catch_const_included

#define CATCHMOD_VER "4.0.3-ReAPI"
#define MAXPLAYERSVAR MAX_PLAYERS + 1

enum Teams
{
	FLEER,
	CATCHER,
	TRAINING,
	NONE
}

new g_szTeamsNames[Teams][MAXPLAYERSVAR] =
{
	"Fleer",
	"Catcher",
	"Training",
	"None"
}