do {
    $path = Read-Host "Enter your filepath"
$filename = Read-Host "Filename"
Write-Host "Results"
function Search-Folder($filePath,$searchFile) {
    $children = Get-ChildItem -Path $filePath
    foreach ($child in $children) {
        $name = $child.Name
        if ($name -match $searchFile) {
            Write-Host "$filePath\$name"
        }
        $isDir = Test-Path -Path "$filePath\$name" -PathType Container
        if ($isDir) {
            Search-Folder -filePath "$filePath\$name" -searchFile $searchFile
        }
    }
}
Search-Folder -filePath $path -searchFile $filename
$response = Read-Host "Do you want to search again(y/n)"
if ($response -eq "y" -or $response -eq "n") {
    continue;
}
else {
    Write-Host "Invalid"
}
} until ($response -eq "n")
Write-Host "Searching Process is Done!!"