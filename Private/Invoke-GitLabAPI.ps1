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
        [Parameter(Mandatory = $true)] 
        [ValidateNotNullOrEmpty()]
        [string]
        $ObjectType,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        $ConfigPath = "$env:appdata\PSGitLab\PSGitLabConfig.xml"
    )

    $GitLabConfig = Import-GitLabAPIConfig $ConfigPath
    $domain = $GitLabConfig.Domain
    #$token = ConvertFrom-SecureString $GitLabConfig.Token
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($GitLabConfig.Token)
    $token = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)

    Write-Host $token
    $headers = @{
        'PRIVATE-TOKEN' = $Token;
    }

    $Request.Add('Headers', $headers)
    $Request.URI = "$Domain/api/v4" + $Request.URI
    $Request.UseBasicParsing = $true

    Write-Host $Request.URI
    try  {
        Write-Verbose "URL: $($Request.URI)"
        $webContent = Invoke-WebRequest @Request
        $totalPages = ($webContent).Headers['X-Total-Pages']
        $results = $webContent.Content | ConvertFrom-Json

        while ($totalPages -gt 0) {
            $newRequest = $Request
            $newRequest.URI = $newRequest.URI + "&page=$($i+1)"
            $Results += (Invoke-WebRequest @newRequest).Content | ConvertFrom-Json
            $totalPages--
        }

        Remove-Variable Token
        Remove-Variable Headers
        Remove-Variable Request
    } 
    catch {
        $ErrorMessage = $_#.exception.response#.statusDescription
        Write-Warning  -Message "$ErrorMessage. See $Domain/help/api/README.md#status-codes for more information."
    }
    
    foreach ($Result in $Results) {
        $Result.pstypenames.insert(0,$ObjectType)
        Write-Output $Result
    }
}
#Export-ModuleMember -Function Invoke-GitLabAPI