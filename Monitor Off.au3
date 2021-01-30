#include <WindowsConstants.au3> ; $WM_SYSCOMMAND = 0x112
#include <MenuConstants.au3>    ; $SC_MONITORPOWER = 0xF170
#include <APISysConstants.au3>  ; $HWND_BROADCAST = 0xFFFF

#NoTrayIcon

#pragma compile(Out, Monitor Off.exe)
#pragma compile(Icon, .\imageres_101.ico)
#pragma compile(UPX, true)
#pragma compile(AutoItExecuteAllowed, false)
#pragma compile(Console, false)
#pragma compile(Compression, 4)
#pragma compile(x64, true)
#pragma compile(FileDescription, Turns the monitor off.)
#pragma compile(FileVersion, 1.0)
#pragma compile(ProductName, Monitor Off)
#pragma compile(ProductVersion, 1.0)

Local $SleepTime = 1000
Local $hDLL = DllOpen("user32.dll")
Enum $MonitorOn = -1, $MonitorStandBy = 1, $MonitorOff

If $CmdLine[0] Then  ; Check if any arguments were given
    $SleepTime = Int($CmdLine[1])  ; 0 is used if 1st argument isn't an int
EndIf

Sleep($SleepTime)

; This line is what turns off the monitor
; https://stackoverflow.com/questions/713498/turn-on-off-monitor
DllCall($hDLL, "INT_PTR", _
    "PostMessage", "hwnd", $HWND_BROADCAST, "UINT", $WM_SYSCOMMAND, _
    "INT_PTR", $SC_MONITORPOWER, "INT_PTR", $MonitorOff)

DllClose($hDLL)
