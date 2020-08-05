Function Reset-GitLabIssueTime {
    <#
    .SYNOPSIS
    Resets the total spent time for this issue to 0 seconds.
    .DESCRIPTION
    Resets the total spent time for this issue to 0 seconds.
    .EXAMPLE
    Reset-GitLabIssueTime -ProjectId 3154 -Issue 8
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/reset_spent_time"

    $Request = @{
        URI=$query
        Method='POST'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}