Function Get-GitLabGroupAccessRequests {
    <#
    .SYNOPSIS
    Gets all access requests of the given group.
    .DESCRIPTION
    Gets all access requests of the given group.
    .EXAMPLE
    Get-GitLabGroupAccessRequests -GroupId 89
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $GroupId
    )

    $Request = @{
        URI="/groups/$GroupId/access_requests"
        Method='GET'
    }

    Invoke-GitLabAPI -Request $Request -ObjectType 'GitLab.Request.Access'
}