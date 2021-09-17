
$token = "eyJ0eXAijUtZDlmOS00hSMT6rq6JvvsouUSjWj3QcAkmXgZ7tdIvq------------------------"
$uriGet = "https://graph.microsoft.com/v1.0/me/events?$select=subject, id"
$uriDelete = "https://graph.microsoft.com/v1.0/me/events/"
$counter = 0

$calendarItem = Invoke-RestMethod -Uri $uriGet -Method Get -Headers @{"Authorization"="Bearer $token"}
Write-Host ""
Write-Host "Preparing to delete all meetings in calendar..." -f Yellow

foreach ($item in $calendarItem)
{
    Write-Warning "Deleting following meetings..."
    Write-Host ""
    Write-Output $item.value.subject
    Write-Host ""

    foreach ($id in $item.value.id)
    {
        Invoke-RestMethod -Uri ($uriDelete + $id) -Method Delete -Headers @{"Authorization"="Bearer $token"}
        $counter++
    }
}
Write-Host "Script has finished deleting all meetings in calendar." -f Green
Write-Host "Total items removed:$counter" -f Green
