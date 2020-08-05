Function Get-GitLabIssueUserAgent {
    <#
    .SYNOPSIS
    Gets user agent details.
    .DESCRIPTION
    Gets user agent details.
    .EXAMPLE
    Get-GitLabIssueUserAgent -ProjectId 3154 -Issue 8
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/user_agent_detail"

    $Request = @{
        URI=$query
        Method='GET'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}