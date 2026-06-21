#This is a brief Powershell script that pulls logs between two timestamps
#declare variables
param (
    [string]$start = "5/19/2026 04:10:00", #earliest timestamp that will be included in output
    [string]$end = "5/19/2026 04:30:00", #last timestamp that will be included in output
    [switch]$powershell, #toggles the output of powershell logs
    [switch]$security, #toggles security logs
    [switch]$all #toggles all logs
)
Get-EventLog -LogName Application -After $start -Before $end;
Get-EventLog -LogName HardwareEvents -After $start -Before $end;
Get-EventLog -LogName System -After $start -Before $end;
if($security -or $all){ #only executes if security or all logs are toggled on
    Get-EventLog -LogName Security -After $start -Before $end;
}
if($powershell -or $all){ #only executes if powershell or all logs are toggled on
    Get-EventLog -LogName 'Windows PowerShell' -After $start -Before $end;
}