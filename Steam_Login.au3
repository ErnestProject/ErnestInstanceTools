#include "WinHttp.au3"

Func _Args($argument, $delimiter)
    If Ubound($CmdLine) > 1 Then
        For $i = 1 To UBound($CmdLine)-1 Step 1
            If StringInStr($CmdLine[$i], $argument, 0) Then
                If StringInStr($CmdLine[$i], $delimiter, 0) Then
                    $value = StringSplit($CmdLine[$i], $delimiter)
                    Return $value[2]
                EndIf
            EndIf
        Next
    EndIf
EndFunc

Func _WinWaitActivate($title,$text,$timeout=0)
	WinWait($title,$text,$timeout)
	If Not WinActive($title,$text) Then WinActivate($title,$text)
	WinWaitActive($title,$text,$timeout)
EndFunc

;& 'C:\Program Files (x86)\AutoIt3\AutoIt3.exe' 'C:\Users\Administrator\Desktop\Steam_Login.au3' '/login:popi' '/password:pipo'

Local $sGet = HttpGet("http://api.com/test/get_action.php")
ConsoleWrite($sGet)

Local $i = 0
While StringInStr($sGet, "quit") <> 1
	$i = $i + 1
	$sGet = HttpGet("http://api.com/test/get_action.php")

	If StringInStr($sGet, "login") == 1 Then
		ConsoleWrite("Take current action..." & @CRLF)
		HttpGet("http://alpha12.me/test/take_action.php")
		ConsoleWrite("Login" & @CRLF)
		Local $aParams = StringSplit($sGet, "%%")

		$login = $aParams[2]
		$password = $aParams[3]

		ConsoleWrite("Login: " & $login & @CRLF)
		;ConsoleWrite("Pwd: " & $password & @CRLF)

		WinClose("[TITLE:Steam Login]")
		Sleep(1500)

		Local $iPID = Run ( "C:\Program Files (x86)\Steam\Steam.exe" )
		ConsoleWrite("Steam pId: " & $iPID & @CRLF)
		Sleep(2300)

		ConsoleWrite("Waiting for Steam" & @CRLF)
		_WinWaitActivate("[TITLE:Steam Login]","")
		;Send($login & "{TAB}" & $password & "{TAB}{SPACE}{TAB}")
		Send($login & "{TAB}" & $password & "{TAB}{SPACE}{TAB}{SPACE}")
		ConsoleWrite("Credentials sent..." & @CRLF)
	EndIf

	If StringInStr($sGet, "logout") == 1 Then
		WinSetState ( "Steam", "", @SW_MAXIMIZE )

		MouseClick("left",22,20,1)
		Sleep(250)
		MouseClick("left",22,45,1)

		_WinWaitActivate("Logout","")
		Send("{ENTER}")
	EndIf


	Sleep(1000)
WEnd



;~ Sleep(100000)
