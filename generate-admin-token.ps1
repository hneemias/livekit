param(
    [string]$ApiKey = "devkey",
    [string]$ApiSecret = "secret"
)

# Gera um token com privilégios de Administrador total (roomAdmin, roomCreate, roomList)
$adminToken = & "$PSScriptRoot\bin\lk.exe" token create `
    --api-key $ApiKey `
    --api-secret $ApiSecret `
    --identity "admin" `
    --admin `
    --valid-for 24h

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   TOKEN DE ADMINISTRADOR GERADO (24h)   " -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host $adminToken -ForegroundColor Green
Write-Host ""
Write-Host "Use este token para autenticar no 'admin-dashboard.html'!" -ForegroundColor White
