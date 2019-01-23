#Get all the DUO Users and their mobile device last login time
Get-DUOuser | select Email, realname, @{N = 'User_Last_Login'; E = {$(ConvertFrom-UnixTime ($_.Last_Login))}}, @{N = 'Mobile_Last_Seen'; E = {$($_.Phones | where {$_.type -match 'mobile'}|
    Select -ExpandProperty Last_Seen |
     Get-Date)}} |
      Sort -Property Last_Login