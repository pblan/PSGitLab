Function Get-GitLabIssueClosingMergeRequests {
    <#
    .SYNOPSIS
    Get all the issue closing merge requests that are related to the issue.
    .DESCRIPTION
    Get all the issue closing merge requests that are related to the issue.
    .EXAMPLE
    Get-GitLabIssueClosingMergeRequests -ProjectId 3154 -Issue 8
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/closed_by"

    $Request = @{
        URI=$query
        Method='GET'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}