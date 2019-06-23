#Clear-Host
$data = Get-ChildItem -Path D:\ -Recurse
[int]$count = 0

Foreach($d in $data){
    if ($d -like "*.jpg" -and ".exe"){
        $count += 1
        Write-Host ("$count : " + $d) -fore Yellow
    }
    else{
        continue
    }
}
Write-Output ("Total count : " + $count)


