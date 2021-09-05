[Int] $num1 = Read-Host "Enter first number"
[Int] $num2 = Read-Host "Enter second number"
$num1 -eq $num2 -and $num1 -gt $num2
$num1 -eq $num2 -or $num1 -gt $num2
$text = "I Love both PowerShell and Bash Shell"
$text_split = $text -split " "
$text_join = $text_split -join " - "
$text_join