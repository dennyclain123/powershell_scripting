# Do-While Loop
$count = 0 #1
do {
    Write-Host $count
    $count = $count +=1
} while ($count -lt 10)

#Do-Until Loop
$count = 0 
do {
    Write-Host $count
    $count = $count +=1
} Until ($count -eq 10)

#While Loop
$count = 0
while ($count -le 10) {
    Write-Host $count
    $count = $count+=1
}
Write-Host "Looping Done"

#For Loop
for ($i = 0; $i -le 5; $i++) {
    Write-Host $i
}

#For Each
$nameList = "Aung Khant Moe","Pe Chit Maung", "Htet Paing", "Min Khant Zeya", "Mg Mg"
foreach ($name in $nameList) {
    Write-Host $name
}
