@echo off
echo Starting LiveKit Server...
echo URL: http://localhost:7880
echo API Key: devkey
echo API Secret: secret
echo.
"%~dp0bin\livekit-server.exe" --config "%~dp0livekit.yaml" --dev
