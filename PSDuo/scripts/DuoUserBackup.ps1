$duouser = Get-DUOuser
foreach ($user in $duouser) {
    $user | Export-Clixml -Path ("~\" + $user.username + "_duobak.clixml")
}