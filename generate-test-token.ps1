param(
    [string]$Room = "demo-room",
    [string]$Identity = "user-" + (Get-Random -Minimum 1000 -Maximum 9999)
)

$token = & "$PSScriptRoot\bin\lk.exe" token create `
    --dev `
    --join `
    --room $Room `
    --identity $Identity

Write-Host "Generated token for Room: '$Room', Identity: '$Identity'" -ForegroundColor Cyan
Write-Host "Token:" -ForegroundColor Green
Write-Host $token
Write-Host ""
Write-Host "Test URL (LiveKit Meet):" -ForegroundColor Cyan
Write-Host "https://meet.livekit.io/#livekit_url=http%3A%2F%2Flocalhost%3A7880&token=$token" -ForegroundColor Yellow
