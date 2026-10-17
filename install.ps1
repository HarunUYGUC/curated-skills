# Curated Skills Installation and Sync Script
param (
    # -------------------------------------------------------------------------
    # TARGET DIRECTORY OPTIONS:
    # - Google Antigravity (Default)    : "$HOME\.gemini\config\skills"
    # - Claude Code (Global)            : "$HOME\.claude\skills"
    # - Cursor / Codex (Project level)  : ".\.agents\skills"
    # - Windsurf / OpenCode             : "$HOME\.windsurf\skills"
    # -------------------------------------------------------------------------
    [string]$TargetDir = "$HOME\.gemini\config\skills",

    # Install ONLY the core skill-manager engine (Clean Slate / Empty Template)
    [switch]$CleanTemplate = $false
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ManifestFile = Join-Path $ScriptDir "skills.json"

if (!(Test-Path $ManifestFile)) {
    Write-Error "Manifest file not found: $ManifestFile"
    exit 1
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Curated Skills & Agent Manager Setup" -ForegroundColor Cyan
Write-Host "Target Directory : $TargetDir" -ForegroundColor Yellow
if ($CleanTemplate) {
    Write-Host "Installation Mode: Clean Slate (Core skill-manager only)" -ForegroundColor Magenta
} else {
    Write-Host "Installation Mode: Full Curated Pack (Curated + Custom skills)" -ForegroundColor Green
}
Write-Host "==========================================================" -ForegroundColor Cyan

if (!(Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
}

$manifest = Get-Content $ManifestFile -Raw -Encoding UTF8 | ConvertFrom-Json

if ($CleanTemplate) {
    # 1. Clean Slate Mode: Install only the core skill-manager engine
    Write-Host "`n[1/1] Installing Core Engine (skill-manager)..." -ForegroundColor Green
    $skillManagerDir = Join-Path $ScriptDir "custom-skills\skill-manager"
    if (Test-Path $skillManagerDir) {
        Write-Host "  -> Installing: skill-manager (Universal Agent Manager)" -ForegroundColor Cyan
        Copy-Item -Path $skillManagerDir -Destination $TargetDir -Recurse -Force
    } else {
        Write-Warning "skill-manager directory not found at $skillManagerDir"
    }

    Write-Host "`n==========================================================" -ForegroundColor Cyan
    Write-Host "Clean Slate Template Initialized Successfully!" -ForegroundColor Green
    Write-Host "Core skill-manager installed. External curated skills skipped." -ForegroundColor Yellow
    Write-Host "You can now use your AI agent to add or create custom skills." -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
} else {
    # 1. Full Mode: Install Custom Skills
    Write-Host "`n[1/2] Installing Custom Skills..." -ForegroundColor Green
    $customSkillsDir = Join-Path $ScriptDir "custom-skills"
    if (Test-Path $customSkillsDir) {
        Get-ChildItem -Directory $customSkillsDir | ForEach-Object {
            $skillName = $_.Name
            Write-Host "  -> Installing: $skillName (Custom Skill)" -ForegroundColor Gray
            Copy-Item -Path $_.FullName -Destination $TargetDir -Recurse -Force
        }
    }

    # 2. Full Mode: Download and Synchronize External Skills
    Write-Host "`n[2/2] Downloading External Skills..." -ForegroundColor Green

    foreach ($skill in $manifest.skills.external) {
        $dest = Join-Path $TargetDir $skill.name
        Write-Host "`n--> [$($skill.name)] - $($skill.author)" -ForegroundColor White

        if ($skill.type -eq "git-clone") {
            if (Test-Path $dest) {
                Write-Host "  [OK] Already exists. Updating (git pull)..." -ForegroundColor DarkGray
                try {
                    git -C $dest pull --ff-only 2>$null
                } catch {
                    Write-Host "  [!] Skipped git pull." -ForegroundColor DarkGray
                }
            } else {
                Write-Host "  [..] Cloning: $($skill.repo)..." -ForegroundColor Cyan
                git clone --depth 1 $skill.repo $dest
            }
        }
        elseif ($skill.type -eq "github-extract") {
            if (!(Test-Path $dest)) {
                New-Item -ItemType Directory -Force -Path $dest | Out-Null
            }

            # Convert GitHub web repo URL dynamically to raw download URL
            $rawBase = $skill.repo.Replace("github.com", "raw.githubusercontent.com") + "/main"
            $skillUrl = "$rawBase/$($skill.subpath)/SKILL.md"
            $targetSkillMd = Join-Path $dest "SKILL.md"

            # Cross-platform curl resolution (curl.exe on Windows, curl on Linux/macOS)
            $curl = if (Get-Command "curl.exe" -ErrorAction SilentlyContinue) { "curl.exe" } else { "curl" }

            Write-Host "  [..] Downloading SKILL.md..." -ForegroundColor Cyan
            & $curl -s -L $skillUrl -o $targetSkillMd

            if ($skill.references) {
                $refDir = Join-Path $dest "references"
                if (!(Test-Path $refDir)) {
                    New-Item -ItemType Directory -Force -Path $refDir | Out-Null
                }

                foreach ($refFile in $skill.references) {
                    # Resolve URL whether given as relative path or filename
                    $refUrl = if ($refFile -match "/") { "$rawBase/$refFile" } else { "$rawBase/references/$refFile" }
                    $refFileName = Split-Path -Leaf $refFile
                    $targetRef = Join-Path $refDir $refFileName
                    Write-Host "    |- Reference: $refFileName" -ForegroundColor DarkGray
                    & $curl -s -L $refUrl -o $targetRef
                }

                # Update relative reference paths inside SKILL.md
                $mdContent = Get-Content $targetSkillMd -Raw -Encoding UTF8
                $mdContent = $mdContent.Replace("../../references/", "./references/")
                Set-Content -Path $targetSkillMd -Value $mdContent -Encoding UTF8
            }
        }

        Write-Host "  [OK] Ready!" -ForegroundColor Green
    }

    Write-Host "`n==========================================================" -ForegroundColor Cyan
    Write-Host "All Curated Skills Successfully Synchronized!" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
}

Get-ChildItem -Path $TargetDir -Directory | Select-Object Name, LastWriteTime | Format-Table -AutoSize
