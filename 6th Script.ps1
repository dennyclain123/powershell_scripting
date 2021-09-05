Write-Host "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
Write-Host "                  Age Condition Script               "
Write-Host "+++++++++++++++++++++++++++++++++++++++++++++++++++++"

[String] $name = Read-Host "Enter your name"
[Int] $age = Read-Host "Enter your age"
if($age -lt 18 -and $age -gt 0){
Write-Host "Hello $name, you are just a boy"
}elseif($age -ge 18 -and $age -lt 40){
Write-Host "Hello $name, you are a man"
}elseif($age -ge 40 -and $age -lt 60){
Write-Host "Hello $name, you are getting old"
}elseif($age -ge 60 -and $age -lt 80){
Write-Host "Hello $name, you are old man"
}else{
Write-Host "Invalid Number"
}