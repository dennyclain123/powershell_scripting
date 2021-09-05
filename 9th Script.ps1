do {
    $name = Read-Host "Enter your name"
    Write-Host "Hello $name"
    $response = Read-Host "Do you want to run a program again(y/n)"
    if ($response -eq "y" -or $response -eq "n") {
        continue;
    }else{
        Write-Host "Invalid"
        break;
    }
} until ($response -eq "n")
Write-Host "Bye"