Function Import-GitLabAPIConfig {
    <#
    .Synopsis
       Check for existing config and writes contents.
    .DESCRIPTION
       Check for existing config and writes contents.
    .EXAMPLE
        Import-GitLabAPIConfig
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        $ConfigPath = "$env:appdata\PSGitLab\PSGitLabConfig.xml"
    )

    if (Test-Path $ConfigPath) {
        Import-Clixml $ConfigPath
    
    } else {
        Write-Error 'Unable to locate config file at $($ConfigPath). You may have to run Save-GitLabAPIConfig.'
        break;
    }
    }