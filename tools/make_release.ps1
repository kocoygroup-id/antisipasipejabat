$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
python "$Root\tools\run_all_audits.py"
Write-Host "Build-time audits complete. On Windows, use tar/7-Zip or WSL to create the release archives; the published release already includes .tar.z and .tgz artifacts."
