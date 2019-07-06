# $video = Get-Item -Path C:\users\Ankur\Downloads\Video\matplotlib*


# foreach ($v in $video){
#     if ($v.Name -like "Matplotlib*" -and $v.Mode -ne "d-----"){
#         Move-Item -Path ($video + $v) -Destination C:\Users\Ankur\Downloads\Video\MatplotLib -Force -ErrorAction SilentlyContinue
#         Write-Output ("Moving item " + $v.Name)
#     }
# }

# New-Item -Path C:\Users\Ankur\Downloads\Video\ -Name "Data_Structure_Python" -ItemType Directory

$path = Get-Item -Path C:\Users\Ankur\Downloads\Video\data*

foreach ($p in $path){
    if ($p.Name -like "Data*" -and $p.Mode -ne "d-----"){
        Write-Output ($p.Name)
        Move-Item -Path ($path + $p) -Destination C:\Users\Ankur\Downloads\Video\Data_Structure_Python -Force -ErrorAction SilentlyContinue
    }
}