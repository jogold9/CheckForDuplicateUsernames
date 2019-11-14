<#

.SYNOPSIS
This Powershell script checks a list of usernames from a CSV file and outputs any usernames that already exist.

.NOTES
This is being done to avoid issues with attempting to use duplicate usernames when creating large numbers of accounts.

#>

# Josh Gold

Import-Module ActiveDirectory

$Users = Import-csv E:\Input\UsernameCheckFile.csv

ForEach ($User in $Users) {
    # Get the username we are checking
    $username = $User.SamAccountName

    # check if username already exists
    
    $result = Get-ADUser -Filter { SamAccountName -eq $username }

    # If username exists, write to screen & to a message to a text file, and set result variable back to false when done
    if ($result) {
        Write-Host $username + " is a duplicate"
        $username + " is a duplicate" | Out-File -FilePath E:\Output\CheckForDuplicateUsernames.txt -Append
        $result = $false
    }
    else {
        Write-Host "Unique username"
    }
}
