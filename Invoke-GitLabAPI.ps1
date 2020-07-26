Function Invoke-GitLabAPI {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $Request,
        [Parameter()] 
        [ValidateNotNullOrEmpty()]
        [string]
        $ObjectType,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        $ConfigPath = "$env:appdata\PSGitLab\PSGitLabConfig.xml"
    )

    $GitLabConfig = Import-GitLabAPIConfig $ConfigPath
    $domain = $GitLabConfig.Domain
    $token = DecryptString -Token $GitLabConfig.Token

    $headers = @{
        'PRIVATE-TOKEN' = $Token;
    }

    $Request.Add('Headers', $headers)
    $Request.URI = "$Domain/api/v4" + $Request.URI
    $Request.UseBasicParsing = $true

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
        $ErrorMessage = $_.exception.response.statusDescription
        Write-Warning  -Message "$ErrorMessage. See $Domain/help/api/README.md#status-codes for more information."
    }
    
    foreach ($Result in $Results) {
        $Result.pstypenames.insert(0,$ObjectType)
        Write-Output $Result
    }
}