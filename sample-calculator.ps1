function add([Int] $num1, [Int] $num2) {
    $total = $num1 + $num2
    Write-Host "Addition value is $total "   
}
function sub([Int] $num1, [Int] $num2) {
    $total = $num1 - $num2
    Write-Host "Substraction value is $total "   
}
function multi([Int] $num1, [Int] $num2) {
    $total = $num1 * $num2
    Write-Host "Multiplication value is $total "   
}
function divide([Int] $num1, [Int] $num2) {
    $total = $num1 / $num2
    Write-Host "Division value is $total "   
}
do {
    [Int] $number1 = Read-Host "Enter first number"
    [Int] $number2 = Read-Host "Enter second number"
    Write-Host "    What do you want to do  "
    Write-Host "  1) Addition  "
    Write-Host "  2) Substraction "
    Write-Host "  3) Multiplication "
    Write-Host "  4) Division "
    $choice = Read-Host "What do you want to do"
    switch ($choice) {
        "1" { add -num1 $number1 -num2 $number2 }
        "2" { sub -num1 $number1 -num2 $number2 }
        "3" { multi -num1 $number1 -num2 $number2 }
        "4" { divide -num1 $number1 -num2 $number2 }
        Default { Write-Host "Invalid Number" }
    }
    $response =  Read-Host "Do you want to calculate again(y/n)"
    if ($response -eq "y" -or $response -eq "n") {
        continue;
    }
    else {
        Write-Host "Invalid"
    }
} until ($response -eq "n")
Write-Host "Exited!"