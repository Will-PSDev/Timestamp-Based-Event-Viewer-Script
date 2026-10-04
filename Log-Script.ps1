#This is a brief Powershell script that pulls logs between two timestamps
#declare variables
param (
    [DateTime]$end = (Get-Date), #last timestamp that will be included in output, defaults to current time
    [DateTime]$start = ($end.AddMinutes(-30)), #earliest timestamp that will be included in output,defaults to 30 minutes prior to $end
    [switch]$powershell, #toggles the output of powershell logs
    [switch]$security, #toggles security logs
    [switch]$all, #toggles all logs
    [string]$message, #dual use, if this parameter is refrenced triggers if condition where events are matched to the string assigned to message
    [switch]$hour, #triggers an if statement where the value of $start is set to 1 hour before the value of $end
    [switch]$day #triggers an if statement where the value of $start is set to 1 day before the value of $end
)

#if hour is called, sets $end to 1 hour prior to $start
if($hour){
    $start = (($end).AddHours(-1));
}

#if day is called, sets $end to 1 day prior to $start
if($day){
    $start = (($end).AddDays(-1));
}

#checks if search term exists, if so it runs the search with the search term
if ($message){
    $events = Get-WinEvent -FilterHashtable @{ 
        LogName =  'Application', 'HardwareEvents', 'System'
        StartTime =  $start 
        EndTime =  $end 
    } | Where-Object { $_.Message -like  $message};
    if($security -or $all){ #only executes if security or all logs are toggled on
        $events += Get-WinEvent -FilterHashtable @{ 
            LogName =  'Security' 
            StartTime =  $start 
            EndTime =  $end 
        } | Where-Object { $_.Message -like  $message};
    }
    if($powershell -or $all){ #only executes if powershell or all logs are toggled on
        $events += Get-WinEvent -FilterHashtable @{ 
            LogName =  'Windows PowerShell' 
            StartTime =  $start 
            EndTime =  $end 
        } | Where-Object { $_.Message -like  $message};
    }
}

#if search term value doesn't exist simply compares timestamps
else {
    $events = Get-WinEvent -FilterHashtable @{ 
        LogName =  'Application', 'HardwareEvents', 'System'
        StartTime =  $start 
        EndTime =  $end
    };
    if($security -or $all){ #only executes if security or all logs are toggled on
        $events += Get-WinEvent -FilterHashtable @{ 
            LogName =  'Security' 
            StartTime =  $start 
            EndTime =  $end
        };
    }
    if($powershell -or $all){ #only executes if powershell or all logs are toggled on
        $events += Get-WinEvent -FilterHashtable @{ 
            LogName =  'Windows PowerShell' 
            StartTime =  $start 
            EndTime =  $end
        };
    }
}

$Events | Sort-Object -Property TimeCreated | Format-Table -Property TimeCreated, Id, LevelDisplayName, ProviderName, Message -AutoSize;

