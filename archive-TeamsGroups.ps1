
$data1 = Import-Csv -Path "C:\Users\ankurb\Downloads\all_Teams.csv" | select DisplayName, GroupId
$data2 = Import-Csv -Path "C:\Users\ankurb\Downloads\TeamsUsage.csv" | select DisplayName, Id

foreach ($d1 in $data1){
    
    foreach ($d2 in $data2){

        if ($d1.GroupId -notin $data2.Id){
            #Set-TeamArchivedState -GroupId $d1.GroupID -Archived:$true
            Write-Host "Archived:" $($d1.DisplayName) -fore Green
            $property = [ordered]@{
                "Group Name" = $($d1.DisplayName)
                "Group Id" = $($d1.GroupID)
            }

            Out-File -FilePath "D:\TeamsArchivedGroups.txt" -InputObject $property -Append -Force
            break
        }
        if ($d1.GroupId -in $data2.Id){
            Write-Host "$($d1.DisplayName): already exists in TeamsUsage file. No action taken!" -fore Cyan
            break
        }
     
    }   
}
    


