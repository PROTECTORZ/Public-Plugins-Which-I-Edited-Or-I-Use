/*
WWW         WWWW        WWW        PPPPPPPPPPPPPPP          MMMMMM             MMMMMM           GGGGGGGGGGGG
WWW         WWWW        WWW        PPPPPPPPPPPPPPPP         MMM MMM           MMM MMM         GGG           GGG
WWW         WWWW        WWW        PPP           PPP        MMM  MMM         MMM  MMM         GGG            GGG
 WWW      WWW  WWW      WWW        PPP            PPP       MMM   MMM       MMM   MMM        GGG              GGG
 WWW      WWW  WWW      WWW        PPP            PPP       MMM    MMM     MMM    MMM        GGG              GGG
 WWW      WWW  WWW      WWW        PPP           PPP        MMM     MMM   MMM     MMM       GGG
  WWW    WWW    WWW    WWW         PPPPPPPPPPPPPPPP         MMM      MMM MMM      MMM       GGG
  WWW    WWW    WWW    WWW         PPPPPPPPPPPPPPP          MMM       MMMMM       MMM      GGG
  WWW    WWW    WWW    WWW         PPP                      MMM                   MMM       GGG         GGGGGGGGGGG
   WWW  WWW      WWW  WWW          PPP                      MMM                   MMM       GGG                 GGG
   WWW  WWW      WWW  WWW          PPP                      MMM                   MMM        GGG               GGG
   WWW  WWW      WWW  WWW          PPP                      MMM                   MMM        GGG               GGG
     WWWW          WWWW            PPP                      MMM                   MMM         GGG             GGG
	 WWWW          WWWW            PPP                      MMM                   MMM         GGG             GGG
	 WWWW          WWWW            PPP                      MMM                   MMM           GGGGGGGGGGGGGGG

TTTTTTTTTTTTTTTTTTTTTTTTTTT
TTTTTTTTTTTTTTTTTTTTTTTTTTT
            TTT
            TTT
			TTT
			TTT                   eeeeeeeeeeee               aaaaaaaaaaaaaaaaaaa          mmm  mmmmmmmmm       mmmmmmmmm
			TTT                  eee        eee             aaa               aaa         mmm mmm     mmm     mmm     mmm
			TTT                 eee          eee                              aaa         mmmmmm       mmm   mmm       mmm
			TTT                eee            eee                             aaa         mmmmm         mmm mmm         mmm
			TTT               eeeeeeeeeeeeeeeeeeee             aaaaaaaaaaaaaaaaaa         mmmm           mm mm           mmm
			TTT                eee                            aaa             aaa         mmm             mmm             mmm
			TTT                 eee                          aaa              aaa         mmm             mmm             mmm
			TTT                  eee                        aaa               aaa         mmm             mmm             mmm
			TTT                   eee        eee             aaa              aaa         mmm             mmm             mmm
			TTT                    eeeeeeeeeeee               aaaaaaaaaaaaaaaaaaa         mmm             mmm             mmm

Print Chat Color by WPMG PRoSToTeM@.
*/

#if defined WPMGPrintChatColorIncluded
	#endinput
#endif

#define WPMGPrintChatColorIncluded

#include <cstrike>

// ������������ ���������� %L � ���������
#define MAX_LANG_ARGS	5

// ����� ���������
enum
{
	PRINT_COLOR_GREY,		// �����
	PRINT_COLOR_RED,		// �������
	PRINT_COLOR_BLUE,		// �����
	PRINT_COLOR_PLAYERTEAM	// ���� ������� ������ �������� �� �������� ��� ���� ������� ������������ ������ (���� PRINT_COLOR_PLAYERTEAM + id)
};

// ����� ������
static const g_aszTeamNames[][] =
{
	"UNASSIGNED",
	"TERRORIST",
	"CT",
	"SPECTATOR"
};

stock PrintChatColor(pReceiver, iColor = PRINT_COLOR_PLAYERTEAM, const szMessage[], any:...)
{
	// ���������
	new szBuffer[256];
	
	// ���������� ����������
	new iArgs = numargs();
	
	// �������� ������ ������
	if (pReceiver)
	{
		// �������� ��� LANG_PLAYER, �� ID ����������
		for (new iArg = 3; iArg < iArgs; iArg++)
		{
			// ���� �������� �� ����� LANG_PLAYER ��� ������
			if (getarg(iArg) != LANG_PLAYER)
				continue;
			
			// ������ ��������� �������� ���������
			setarg(iArg, _, pReceiver);
		}
		
		// ����������� ���������
		vformat(szBuffer, 255, szMessage, 4);
		
		// �������� !y, !t, !g �� �����
		while (replace(szBuffer, 255, "!y", "^1")) {}
		while (replace(szBuffer, 255, "!t", "^3")) {}
		while (replace(szBuffer, 255, "!g", "^4")) {}
		
		// ���� ���� PLAYERTEAM
		if (iColor >= PRINT_COLOR_PLAYERTEAM)
			// �������� ��������� ������, �� ����������� ���� ���� ����������, ���� ���������� ������
			UTIL_SayText(MSG_ONE, _, pReceiver, (iColor > PRINT_COLOR_PLAYERTEAM) ? iColor - PRINT_COLOR_PLAYERTEAM : pReceiver, szBuffer);
		else
		{
			// �������� ������� ����������
			new iTeam = _:cs_get_user_team(pReceiver);
			
			// ���� ������� ����� ����� ����� ��������� ���������
			if (iTeam % 3 == iColor)
				UTIL_SayText(MSG_ONE, _, pReceiver, pReceiver, szBuffer);
			else
			{
				// ������ ������� (��� �����)
				UTIL_TeamInfo(MSG_ONE, _, pReceiver, pReceiver, g_aszTeamNames[iColor]);
				// �������� ���������
				UTIL_SayText(MSG_ONE, _, pReceiver, pReceiver, szBuffer);
				// ���������� �������
				UTIL_TeamInfo(MSG_ONE, _, pReceiver, pReceiver, g_aszTeamNames[iTeam]);
			}
		}
	}
	// �������� ����
	else
	{
		// ������ ��� ����������
		new aiChangeArgs[MAX_LANG_ARGS];
		// ���������� ����������, ������� ��������
		new iChangeArgs, iArg;
		
		// ���������� ��� ��������� ���������� LANG_PLAYER
		for (iArg = 3; iArg < iArgs; iArg++)
		{
			// ���� �������� �� ����� LANG_PLAYER ��� ������
			if (getarg(iArg) != LANG_PLAYER)
				continue;
			
			// ���������� � ������
			aiChangeArgs[iChangeArgs++] = iArg;
			
			// ���� ��������� �������� ������� �� �����
			if (iChangeArgs == MAX_LANG_ARGS)
				break;
		}
		
		// ������ �� �������
		new apPlayers[32];
		// ����� �������
		new iPlayers;
		// ��������� �����
		new pPlayer;
		
		// �������� �������
		get_players(apPlayers, iPlayers);
		
		// ������ ���� �� �������
		for (new i = 0; i < iPlayers; i++)
		{
			// ��������� ���������� ������
			pPlayer = apPlayers[i];
			
			// ������ ��������� LANG_PLAYER �� ID ������
			for (iArg = 0; iArg < iChangeArgs; iArg++)
				setarg(aiChangeArgs[iArg], _, pPlayer);
			
			// ����������� ���������
			vformat(szBuffer, 255, szMessage, 4);
			
			// �������� !y, !t, !g �� �����
			while (replace(szBuffer, 255, "!y", "^1")) {}
			while (replace(szBuffer, 255, "!t", "^3")) {}
			while (replace(szBuffer, 255, "!g", "^4")) {}
			
			// ���� ���� PLAYERTEAM
			if (iColor >= PRINT_COLOR_PLAYERTEAM)
				// �������� ��������� ������, �� ����������� ���� ���� ����������, ���� ���������� ������
				UTIL_SayText(MSG_ONE, _, pPlayer, (iColor > PRINT_COLOR_PLAYERTEAM) ? iColor - PRINT_COLOR_PLAYERTEAM : pPlayer, szBuffer);
			else
			{
				// �������� ������� ����������
				new iTeam = _:cs_get_user_team(pPlayer);
				
				// ���� ������� ����� ����� ����� ��������� ���������
				if (iTeam % 3 == iColor)
					UTIL_SayText(MSG_ONE, _, pPlayer, pPlayer, szBuffer);
				else
				{
					// ������ ������� (��� �����)
					UTIL_TeamInfo(MSG_ONE, _, pPlayer, pPlayer, g_aszTeamNames[iColor]);
					// �������� ���������
					UTIL_SayText(MSG_ONE, _, pPlayer, pPlayer, szBuffer);
					// ���������� �������
					UTIL_TeamInfo(MSG_ONE, _, pPlayer, pPlayer, g_aszTeamNames[iTeam]);
				}
			}
		}
	}
}

// ������� ������� SayText
stock UTIL_SayText(iDest, const vecOrigin[3] = {0, 0, 0}, pEntity, pSender, const szMessage[], const szArg1[] = "", const szArg2[] = "")
{
	// �������� ID ��������� SayText
	static msgSayText;
	
	if (!msgSayText)
		msgSayText = get_user_msgid("SayText");
	
	// �������� SayText
	message_begin(iDest, msgSayText, vecOrigin, pEntity);
	write_byte(pSender);
	write_string(szMessage);
	if (szArg1[0])
	{
		write_string(szArg1);
		
		if (szArg2[0])
			write_string(szArg2);
	}
	message_end();
}

// ������� ������� TeamInfo
stock UTIL_TeamInfo(iDest, const vecOrigin[3] = {0, 0, 0}, pEntity, pPlayer, const szTeamName[])
{
	// �������� ID ��������� TeamInfo
	static msgTeamInfo;
	
	if (!msgTeamInfo)
		msgTeamInfo = get_user_msgid("TeamInfo");
	
	// �������� TeamInfo
	message_begin(iDest, msgTeamInfo, vecOrigin, pEntity);
	write_byte(pPlayer);
	write_string(szTeamName);
	message_end();
}