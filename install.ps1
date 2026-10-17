# Curated Skills Installation and Sync Script
param (
    # -------------------------------------------------------------------------
    # TARGET DIRECTORY OPTIONS:
    # If not explicitly provided, HostChoice determines the target directories.
    # -------------------------------------------------------------------------
    [string]$TargetDir = "",
    [string[]]$TargetDirs = @(),

    # Host selection: 'auto' (detect all installed AI tools), 'gemini', 'claude', 'cursor', 'windsurf', 'all'
    [string]$HostChoice = "auto",

    # Install ONLY the core skill-manager engine (Clean Slate / Empty Template)
    [switch]$CleanTemplate = $false,

    # Bypass confirmation prompt in Clean Slate mode (useful for automated scripts)
    [switch]$Force = $false
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ManifestFile = Join-Path $ScriptDir "skills.json"
$TemplateFile = Join-Path $ScriptDir "skills.template.json"

if (!(Test-Path $ManifestFile)) {
    if (Test-Path $TemplateFile) {
        Copy-Item -Path $TemplateFile -Destination $ManifestFile -Force
    } else {
        Write-Error "Manifest file not found: $ManifestFile"
        exit 1
    }
}

# -------------------------------------------------------------------------
# RESOLVE TARGET DIRECTORIES
# -------------------------------------------------------------------------
$resolvedTargets = [System.Collections.Generic.List[string]]::new()
$targetDescriptions = [System.Collections.Generic.List[string]]::new()

$knownHosts = @{
    "gemini"   = @{ Name = "Google Antigravity"; Root = "$HOME\.gemini";   Path = "$HOME\.gemini\config\skills" }
    "claude"   = @{ Name = "Claude Code";        Root = "$HOME\.claude";   Path = "$HOME\.claude\skills" }
    "cursor"   = @{ Name = "Cursor";             Root = "$HOME\.cursor";   Path = "$HOME\.cursor\skills" }
    "windsurf" = @{ Name = "Windsurf";           Root = "$HOME\.windsurf"; Path = "$HOME\.windsurf\skills" }
}

if ($TargetDir) {
    $resolvedTargets.Add($TargetDir)
    $targetDescriptions.Add("Explicit Target: $TargetDir")
}
elseif ($TargetDirs.Count -gt 0) {
    foreach ($dir in $TargetDirs) {
        $resolvedTargets.Add($dir)
        $targetDescriptions.Add("Target: $dir")
    }
}
elseif ($HostChoice -eq "gemini") {
    $resolvedTargets.Add($knownHosts["gemini"].Path)
    $targetDescriptions.Add($knownHosts["gemini"].Name)
}
elseif ($HostChoice -eq "claude") {
    $resolvedTargets.Add($knownHosts["claude"].Path)
    $targetDescriptions.Add($knownHosts["claude"].Name)
}
elseif ($HostChoice -eq "cursor") {
    $resolvedTargets.Add($knownHosts["cursor"].Path)
    $targetDescriptions.Add($knownHosts["cursor"].Name)
}
elseif ($HostChoice -eq "windsurf") {
    $resolvedTargets.Add($knownHosts["windsurf"].Path)
    $targetDescriptions.Add($knownHosts["windsurf"].Name)
}
else {
    # 'auto' or 'all': Auto-detect installed AI tools on this machine
    foreach ($key in @("gemini", "claude", "cursor", "windsurf")) {
        $hostInfo = $knownHosts[$key]
        if (Test-Path $hostInfo.Root) {
            $resolvedTargets.Add($hostInfo.Path)
            $targetDescriptions.Add("$($hostInfo.Name) ($($hostInfo.Path))")
        }
    }

    # If no AI agent directory was detected, default to Google Antigravity
    if ($resolvedTargets.Count -eq 0) {
        $resolvedTargets.Add($knownHosts["gemini"].Path)
        $targetDescriptions.Add("$($knownHosts['gemini'].Name) (Default: $($knownHosts['gemini'].Path))")
    }
}

$primaryTarget = $resolvedTargets[0]

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Curated Skills & Agent Manager Setup" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Target Environment(s):" -ForegroundColor Yellow
foreach ($desc in $targetDescriptions) {
    Write-Host "  -> $desc" -ForegroundColor Yellow
}

if ($CleanTemplate) {
    Write-Host "`nInstallation Mode: Clean Slate (Core skill-manager only)" -ForegroundColor Magenta
} else {
    Write-Host "`nInstallation Mode: Full Curated Pack (Curated + Custom skills)" -ForegroundColor Green
}
Write-Host "==========================================================" -ForegroundColor Cyan

# Ensure primary target exists
if (!(Test-Path $primaryTarget)) {
    New-Item -ItemType Directory -Force -Path $primaryTarget | Out-Null
}

if ($CleanTemplate) {
    # Safety confirmation prompt every time Clean Slate is requested
    if (!$Force) {
        Write-Host "`n==========================================================" -ForegroundColor Yellow
        Write-Host "[!] CONFIRMATION REQUIRED: Clean Slate Mode" -ForegroundColor Yellow
        Write-Host "==========================================================" -ForegroundColor Yellow
        Write-Host "This will reset 'skills.json' to an empty template (only skill-manager)." -ForegroundColor White
        Write-Host "Any external or custom skills in skills.json will be cleared." -ForegroundColor White
        Write-Host "==========================================================" -ForegroundColor Yellow

        $confirmation = Read-Host "`nAre you sure you want to reset skills.json? [y/N] (Default: N)"
        if ($confirmation -notmatch "^[yY]$") {
            Write-Host "`n[x] Clean Slate cancelled. Your 'skills.json' was NOT modified." -ForegroundColor Cyan
            Write-Host "Exiting setup safely." -ForegroundColor Green
            exit 0
        }
    }

    # Activate clean template as skills.json
    if (Test-Path $TemplateFile) {
        Write-Host "`n  [i] Initializing clean manifest: skills.json" -ForegroundColor DarkGray
        Copy-Item -Path $TemplateFile -Destination $ManifestFile -Force
    }

    # 1. Clean Slate Mode: Install only the core skill-manager engine
    Write-Host "`n[1/1] Installing Core Engine (skill-manager)..." -ForegroundColor Green
    $skillManagerDir = Join-Path $ScriptDir "custom-skills\skill-manager"
    if (Test-Path $skillManagerDir) {
        Write-Host "  -> Installing: skill-manager (Universal Agent Manager)" -ForegroundColor Cyan
        Copy-Item -Path $skillManagerDir -Destination $primaryTarget -Recurse -Force
    } else {
        Write-Warning "skill-manager directory not found at $skillManagerDir"
    }

    Write-Host "`n==========================================================" -ForegroundColor Cyan
    Write-Host "Clean Slate Template Initialized Successfully!" -ForegroundColor Green
    Write-Host "Core skill-manager installed and skills.json initialized with clean template." -ForegroundColor Yellow
    Write-Host "You can now use your AI agent to add or create custom skills." -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan
} else {
    $manifest = Get-Content $ManifestFile -Raw -Encoding UTF8 | ConvertFrom-Json

    # 1. Full Mode: Install Custom Skills to Primary Target
    Write-Host "`n[1/2] Installing Custom Skills..." -ForegroundColor Green
    $customSkillsDir = Join-Path $ScriptDir "custom-skills"
    if (Test-Path $customSkillsDir) {
        Get-ChildItem -Directory $customSkillsDir | ForEach-Object {
            $skillName = $_.Name
            Write-Host "  -> Installing: $skillName (Custom Skill)" -ForegroundColor Gray
            Copy-Item -Path $_.FullName -Destination $primaryTarget -Recurse -Force
        }
    }

    # 2. Full Mode: Download and Synchronize External Skills to Primary Target
    Write-Host "`n[2/2] Downloading External Skills..." -ForegroundColor Green

    foreach ($skill in $manifest.skills.external) {
        $dest = Join-Path $primaryTarget $skill.name
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
    Write-Host "Primary Target Successfully Synchronized!" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
}

# -------------------------------------------------------------------------
# REPLICATE TO ADDITIONAL AI HOSTS (LOCAL SSD COPY - NO RE-DOWNLOADING)
# -------------------------------------------------------------------------
if ($resolvedTargets.Count -gt 1) {
    Write-Host "`n==========================================================" -ForegroundColor Cyan
    Write-Host "Replicating Skills to Additional AI Environments (Local SSD Sync)..." -ForegroundColor Cyan
    Write-Host "==========================================================" -ForegroundColor Cyan

    for ($i = 1; $i -lt $resolvedTargets.Count; $i++) {
        $secondaryTarget = $resolvedTargets[$i]
        Write-Host "`n--> Syncing to: $secondaryTarget" -ForegroundColor Yellow

        if (!(Test-Path $secondaryTarget)) {
            New-Item -ItemType Directory -Force -Path $secondaryTarget | Out-Null
        }

        # Local fast copy
        Copy-Item -Path "$primaryTarget\*" -Destination $secondaryTarget -Recurse -Force
        Write-Host "    [OK] Synchronized in milliseconds!" -ForegroundColor Green
    }
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "All Targets Complete! Summary of Installed Skills:" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan

foreach ($target in $resolvedTargets) {
    Write-Host "`n[Target Directory] $target" -ForegroundColor Cyan
    if (Test-Path $target) {
        Get-ChildItem -Path $target -Directory | Select-Object Name, LastWriteTime | Format-Table -AutoSize
    }
}
