param(
    [Parameter(Mandatory = $true)] [int]$FromX,
    [Parameter(Mandatory = $true)] [int]$FromY,
    [Parameter(Mandatory = $true)] [int]$ToX,
    [Parameter(Mandatory = $true)] [int]$ToY
)

Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class DragInput {
    [DllImport("user32.dll")] public static extern bool SetProcessDPIAware();
    [DllImport("user32.dll")] public static extern void mouse_event(uint flags, uint dx, uint dy, uint data, UIntPtr extraInfo);
}
'@
[DragInput]::SetProcessDPIAware() | Out-Null
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Cursor]::Position = [System.Drawing.Point]::new($FromX, $FromY)
[DragInput]::mouse_event(0x0002, 0, 0, 0, [UIntPtr]::Zero)
Start-Sleep -Milliseconds 200
[System.Windows.Forms.Cursor]::Position = [System.Drawing.Point]::new($ToX, $ToY)
Start-Sleep -Milliseconds 200
[DragInput]::mouse_event(0x0004, 0, 0, 0, [UIntPtr]::Zero)
