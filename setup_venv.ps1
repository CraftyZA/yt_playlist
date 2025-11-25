# Creates a local Python virtual environment in .venv and installs project dependencies
# Usage: Right-click the file and select "Run with PowerShell" OR run: powershell -ExecutionPolicy Bypass -File .\setup_venv.ps1

$ErrorActionPreference = "Stop"

function Write-Section($msg) {
  Write-Host "`n=== $msg ===" -ForegroundColor Cyan
}

Write-Section "Checking Python"
try {
  $pyVersion = python -c "import sys; print(sys.version.split()[0])"
  Write-Host "Python found: $pyVersion" -ForegroundColor Green
} catch {
  Write-Error "Python is not installed or not on PATH. Install Python 3.8+ from https://www.python.org/downloads/ and try again."
  exit 1
}

Write-Section "Creating virtual environment at .venv"
if (-Not (Test-Path ".venv")) {
  python -m venv .venv
  Write-Host "Created .venv" -ForegroundColor Green
} else {
  Write-Host ".venv already exists, reusing it" -ForegroundColor Yellow
}

$venvPython = Join-Path ".venv" "Scripts\python.exe"
if (-Not (Test-Path $venvPython)) {
  Write-Error "Virtual environment looks corrupt. Delete the .venv folder and run this script again."
  exit 1
}

Write-Section "Upgrading pip and installing dependencies"
& $venvPython -m pip install --upgrade pip
if (Test-Path "requirements.txt") {
  & $venvPython -m pip install -r requirements.txt
} else {
  Write-Host "No requirements.txt found; skipping dependency installation" -ForegroundColor Yellow
}

Write-Section "Done"
Write-Host "Activate the environment with:" -ForegroundColor Green
Write-Host ".\\.venv\\Scripts\\Activate.ps1" -ForegroundColor White
