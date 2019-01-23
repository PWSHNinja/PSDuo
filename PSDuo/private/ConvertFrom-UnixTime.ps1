function ConvertFrom-UnixTime($UnixTime)
{
    $epox = get-date -Date '01/01/1970'
    $timespan = New-Timespan -Seconds $UnixTime
    Write-Output $($epox + $timespan)
}