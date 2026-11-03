param(
    [Parameter(Mandatory = $true)] [int]$X,
    [Parameter(Mandatory = $true)] [int]$Y
)

Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class MouseInput {
    [DllImport("user32.dll")]
    public static extern bool SetProcessDPIAware();
    [DllImport("user32.dll")]
    public static extern void mouse_event(uint flags, uint dx, uint dy, uint data, UIntPtr extraInfo);
}
'@

[MouseInput]::SetProcessDPIAware() | Out-Null
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Cursor]::Position = [System.Drawing.Point]::new($X, $Y)
[MouseInput]::mouse_event(0x0002, 0, 0, 0, [UIntPtr]::Zero)
[MouseInput]::mouse_event(0x0004, 0, 0, 0, [UIntPtr]::Zero)
