#requires -version 2
# This is not my script, it was found here:
# http://web.archive.org/web/20170516120430/http://poshcode.org/2049
#
 
if (-not ("win32.nativemethods" -as [type])) {
# import sendmessagetimeout from win32
add-type -Namespace Win32 -Name NativeMethods -MemberDefinition @"
[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
public static extern IntPtr SendMessageTimeout(
   IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
   uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
"@
}
 
$HWND_BROADCAST = [intptr]0xffff;
$WM_SETTINGCHANGE = 0x1a;
$result = [uintptr]::zero
 
# notify all windows of environment block change
[win32.nativemethods]::SendMessageTimeout($HWND_BROADCAST, $WM_SETTINGCHANGE,
[uintptr]::Zero, "Environment", 2, 5000, [ref]$result); 
