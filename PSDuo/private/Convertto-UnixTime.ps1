function ConvertTo-UnixTime($time)
{
    $epox = get-date -Date '01/01/1970'
    $timespan = New-Timespan -Start $epox -End $time | Select-Object -ExpandProperty TotalSeconds
    Write-Output $timespan
}