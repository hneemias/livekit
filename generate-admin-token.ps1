param(
    [string]$ApiKey = "inovar_livekit_key_2026",
    [string]$ApiSecret = "sec_livekit_inovar_9988223311aabbcc"
)

# Gera um token com privilégios de Administrador total (roomAdmin, roomCreate, roomList)
$adminToken = & "$PSScriptRoot\bin\lk.exe" token create `
    --api-key $ApiKey `
    --api-secret $ApiSecret `
    --identity "super-admin" `
    --list `
    --create `
    --grant '{\"roomAdmin\":true}' `
    --valid-for 720h `
    --token-only

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   TOKEN DE ADMINISTRADOR GERADO (30 dias) " -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host $adminToken -ForegroundColor Green
Write-Host ""
Write-Host "Use este token para autenticar no 'admin-dashboard.html'!" -ForegroundColor White
