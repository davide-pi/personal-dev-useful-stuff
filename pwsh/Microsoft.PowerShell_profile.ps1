# Loads posh-git for enhanced git prompt support in PowerShell.
Import-Module posh-git

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

# Add more module imports or customizations below as needed.