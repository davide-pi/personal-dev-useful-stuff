# HACK: needed by PwshSpectreConsole, otherwise some functionality could not work properly
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# Loads modules
Import-Module posh-git -ErrorAction SilentlyContinue
Import-Module PwshSpectreConsole -ErrorAction SilentlyContinue

# Customizes the prompt style with timestamp, colors, and abbreviations.
function Set-PoshGitStyle {
    $GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "MM-dd HH:mm:ss") '
    $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::DarkGray

    $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = '#967bb6'

    $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
    $GitPromptSettings.DefaultPromptPath.ForegroundColor = '#967bb6'
    $GitPromptSettings.DefaultPromptWriteStatusFirst = $false
}

Set-PoshGitStyle

# Function to compare local branches against origin/master and display how many commits they are behind.
function Test-CommitsBehindCount {
    $remoteBranches = Invoke-SpectreCommandWithStatus -Spinner "Dots2" -Title "Comparing branches..." -ScriptBlock {
        Write-SpectreHost "[grey]Fetching...[/]"
        git fetch --all --prune

        Write-SpectreHost "[grey]Getting origin branches list...[/]"
        $remoteBranches = git branch -r | Where-Object {
            ($_ -notmatch 'HEAD') -and ($_ -notmatch "/master$")
        } | ForEach-Object {
            ($_ -replace 'origin/', '').Trim()
        }

        return $remoteBranches
    }


    $result = Invoke-SpectreCommandWithProgress -ScriptBlock {
        param (
            [Spectre.Console.ProgressContext] $Context
        )

        $task = $Context.AddTask("Comparing branches")

        $behindCountData = @()
        foreach ($branch in $remoteBranches) {
            $task.Increment(100 / $remoteBranches.Count)
            try {
                $behindCount = git rev-list --left-right --count origin/$branch..origin/master | ForEach-Object {
                    $parts = $_ -split "`t"
                    if ($parts.Length -eq 2) { [int]$parts[1] } else { 0 }
                }
                $behindCountData += [pscustomobject] @{
                    Label = "origin/$branch"
                    Value = $behindCount
                }
            }
            catch {
                $_ | Format-SpectreException -ExceptionFormat ShortenEverything
            }
        }
        $task.Increment(100 / $remoteBranches.Count)

        return $behindCountData
    }


    $result | ForEach-Object {
        $color = [Spectre.Console.Color]::White
        switch ($_.Value) {
            { $_ -eq 0 } { $color = [Spectre.Console.Color]::Green1; break }
            { $_ -lt 3 } { $color = [Spectre.Console.Color]::Yellow1; break }
            { $_ -lt 5 } { $color = [Spectre.Console.Color]::Orange1; break }
            default { $color = [Spectre.Console.Color]::OrangeRed1 }
        }

        return New-SpectreChartItem -Label "$($_.Label)" -Value $_.Value -Color $color
    } | Format-SpectreBarChart
}

# Add more module imports or customizations below as needed.