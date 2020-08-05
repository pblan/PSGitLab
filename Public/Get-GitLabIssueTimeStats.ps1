Function Get-GitLabIssueTimeStats {
    <#
    .SYNOPSIS
    Gets time tracking stats for an issue.
    .DESCRIPTION
    Gets time tracking stats for an issue.
    .EXAMPLE
    Get-GitLabIssueTimeStats -ProjectId 3154 -Issue 8
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/time_stats"

    $Request = @{
        URI=$query
        Method='GET'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}