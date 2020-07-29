Function Invoke-GitLabAPI {
    <#
    .Synopsis
       Invokes a given GitLab-API request according to a certain GitLab config.
    .DESCRIPTION
       Invokes a given GitLab-API request according to a certain GitLab config.
    .EXAMPLE
        Invoke-GitLabAPI -Request $Request -Format 'GitLab.Project.Event'
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Request,
        <#
        [Parameter(Mandatory = $true)] 
        [ValidateNotNullOrEmpty()]
        [string]
        $ObjectType,
        #>
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        $ConfigPath = "$env:appdata\PSGitLab\PSGitLabConfig.xml"
    )

    $GitLabConfig = Import-GitLabAPIConfig $ConfigPath
    $domain = $GitLabConfig.Domain
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($GitLabConfig.Token)
    $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    Write-Host $token
    $headers = @{
        'PRIVATE-TOKEN' = $Token;
    }

    $Request.Add('Headers', $headers)
    $Request.URI = "$Domain/api/v4" + $Request.URI
    $Request.UseBasicParsing = $true

    try  {
        Write-Verbose "URL: $($Request.URI)"
        $webContent = Invoke-RestMethod -FollowRelLink @Request
        Write-Verbose "Web Content: $($webContent)"
        $Result = $webContent

        Remove-Variable Token
        Remove-Variable Headers
        Remove-Variable Request
    } 
    catch {
        $ErrorMessage = $_#.exception.response#.statusDescription
        Write-Warning  -Message "$ErrorMessage. See $Domain/help/api/README.md#status-codes for more information."
    }
    
    #$Result.pstypenames.insert(0,$ObjectType)
    Write-Output $Result
}