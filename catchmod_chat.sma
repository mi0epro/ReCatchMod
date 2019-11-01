// Defaults
#include <amxmodx>
#include <amxmisc>

// Modules
// #include <cstrike>
#include <reapi>
// #include <engine>
// #include <fakemeta>
// #include <hamsandwich>
// #include <fun>
// #include <xs>
// #include <sqlx>
// #include <nvault>

// 3rd Part
#include <catchmod>
#include <cromchat>

// mi0 utils
// #define UTIL_FADEEFFECT
// #define UTIL_HUDMESSAGE
// #define UTIL_CLIENTCMD
// #define UTIL_LICENSE 0
// #define UTIL_KUR print_chat

// #include <mi0_utils>

// Pragmas
// Add your code here...

// Defines
// Main plugin Defines
#define PLUGIN  "Catch Mod: Chat Manager"
#define VERSION CATCHMOD_VER
#define AUTHOR  "mi0"

// Enums
// Add your code here...

// Global Vars
// Add your code here...

// Plugin forwards
public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	register_concmd("say", "CMD_Say")
	register_clcmd("say_team", "CMD_SayTeam")
}

// Cmds
public CMD_Say(id)
{
	new szMsg[192]
	read_args(szMsg, charsmax(szMsg))
	remove_quotes(szMsg)
	func_SendMessage(id, szMsg)

	return PLUGIN_HANDLED
}

public CMD_SayTeam(id)
{
	new szMsg[192]
	read_args(szMsg, charsmax(szMsg))
	remove_quotes(szMsg)
	func_SendMessage(id, szMsg, true)

	return PLUGIN_HANDLED
}

// Menus
// Add your code here...

// Ham/Reapi/Fm/Engine Forwards
// Add your code here...

// Custom Functions
func_SendMessage(id, szMsg[192], bool:bMsgToTeam = false)
{
	new szNewMsg[192], szPrefix[64]
	new iInGameTeam = get_member(id, m_iTeam)
	new Teams:iPlayerTeam = catchmod_get_user_team(id)

	if (id == 0)
	{
		formatex(szNewMsg, charsmax(szNewMsg), "&x05[Server] &x01%s", szMsg)
		CC_SendMessage(0, szNewMsg)
		return
	}
	else if (iInGameTeam != 4)
	{
		new szColor[8]
		
		if (iInGameTeam == 3)
		{
			formatex(szColor, charsmax(szColor), "&x05")
		}
		else
		{
			switch (iPlayerTeam)
			{
				case FLEER:
				{
					formatex(szColor, charsmax(szColor), "&x04")
				}

				case CATCHER:
				{
					formatex(szColor, charsmax(szColor), "&x07")
				}

				case TRAINING:
				{
					formatex(szColor, charsmax(szColor), "&x06")
				}
			}
		}

		format(szPrefix, charsmax(szPrefix), "%s%s%s[%s]", 
			is_user_admin(id) ? "&x04[&x01Admin&x04] &x01" : "", 
			bMsgToTeam ? "&x04[&x01Team&x04] &x01" : "", 
			szColor, iInGameTeam == 3 ? "Spec" : g_szTeamsNames[iPlayerTeam])
	}
	else 
	{
		return
	}

	new szName[32]
	get_user_name(id, szName, charsmax(szName))

	formatex(szNewMsg, charsmax(szNewMsg), "%s &x01%s: %s", szPrefix, szName, szMsg)

	switch (bMsgToTeam)
	{
		case false:
		{
			CC_SendMessage(0, szNewMsg)
		}

		case true:
		{
			new iPlayers[32], iPlayersNum, iTempID
			get_players(iPlayers, iPlayersNum)

			for(--iPlayersNum; iPlayersNum >= 0; iPlayersNum--)
			{
				iTempID = iPlayers[iPlayersNum]
				if (is_user_admin(iTempID) || catchmod_get_user_team(iTempID) == iPlayerTeam)
				{
					CC_SendMessage(iPlayers[iPlayersNum], szNewMsg)
				}
			}
		}
	}
}

// Stocks
// Add your code here...

// Natives
// Add your code here...