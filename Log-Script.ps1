#This is a brief Powershell script that pulls logs between two timestamps
#declare variables
param (
    [string]$start = "7/26/2026 04:10:00", #earliest timestamp that will be included in output
    [string]$end = "7/26/2026 04:30:00", #last timestamp that will be included in output
    [switch]$powershell, #toggles the output of powershell logs
    [switch]$security, #toggles security logs
    [switch]$all, #toggles all logs
    [string]$message #dual use, if this parameter is refrenced triggers if condition where events are matched to the string assigned to message
)
#checks if search term exists, if so it runs the search with the search term
if ($message){
    $events = Get-EventLog -LogName Application -After $start -Before $end -Message $message;
    $events += Get-EventLog -LogName HardwareEvents -After $start -Before $end -Message $message;
    $events += Get-EventLog -LogName System -After $start -Before $end -Message $message;
    if($security -or $all){ #only executes if security or all logs are toggled on
        $events += Get-EventLog -LogName Security -After $start -Before $end -Message $message;
    }
    if($powershell -or $all){ #only executes if powershell or all logs are toggled on
        $events += Get-EventLog -LogName 'Windows PowerShell' -After $start -Before $end -Message $message;
    }
}
#if search term value doesn't exist simply compares timestamps
else {
    $events = Get-EventLog -LogName Application -After $start -Before $end;
    $events += Get-EventLog -LogName HardwareEvents -After $start -Before $end;
    $events += Get-EventLog -LogName System -After $start -Before $end;
    if($security -or $all){ #only executes if security or all logs are toggled on
        $events += Get-EventLog -LogName Security -After $start -Before $end;
    }
    if($powershell -or $all){ #only executes if powershell or all logs are toggled on
        $events += Get-EventLog -LogName 'Windows PowerShell' -After $start -Before $end;
    }
}
$Events | Sort-Object -Property TimeGenerated
