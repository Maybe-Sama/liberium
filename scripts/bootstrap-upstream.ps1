$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$upstreams = Join-Path (Split-Path -Parent $root) "_upstreams"
New-Item -ItemType Directory -Force -Path $upstreams | Out-Null

$woonext = Join-Path $upstreams "woonext"
$nextwoo = Join-Path $upstreams "next-woo"

if (-not (Test-Path $woonext)) {
  git clone https://github.com/Invizo/woonext.git $woonext
} else {
  Write-Host "WooNext already exists: $woonext"
}

if (-not (Test-Path $nextwoo)) {
  git clone https://github.com/9d8dev/next-woo.git $nextwoo
} else {
  Write-Host "Next Woo already exists: $nextwoo"
}

Write-Host ""
Write-Host "Upstreams ready in $upstreams"
Write-Host "Primary audit target: $woonext"
Write-Host "Read this project's CLAUDE.md and docs/IMPLEMENTATION_PLAN.md before merging/copying anything."
