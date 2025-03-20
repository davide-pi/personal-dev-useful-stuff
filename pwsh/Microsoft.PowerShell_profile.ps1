Import-Module posh-git

function Set-PoshGitStyle {
    $GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "MM-dd HH:mm:ss") '
    $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::DarkGray

    $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = '#967bb6'

    $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
    $GitPromptSettings.DefaultPromptPath.ForegroundColor = '#967bb6'
    $GitPromptSettings.DefaultPromptWriteStatusFirst = $false
}

Set-PoshGitStyle