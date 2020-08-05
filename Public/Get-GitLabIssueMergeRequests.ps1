Function Get-GitLabIssueMergeRequests {
    <#
    .SYNOPSIS
    Get all the merge requests that are related to the issue.
    .DESCRIPTION
    Get all the merge requests that are related to the issue.
    .EXAMPLE
    Get-GitLabIssueMergeRequests -ProjectId 3154 -Issue 8
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/related_merge_requests"

    $Request = @{
        URI=$query
        Method='GET'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}