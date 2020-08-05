Function Reset-GitLabIssueTimer {
    <#
    .SYNOPSIS
    Resets the estimated time for this issue to 0 seconds.
    .DESCRIPTION
    Resets the estimated time for this issue to 0 seconds.
    .EXAMPLE
    Reset-GitLabIssueTimer -ProjectId 3154 -Issue 8
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/reset_time_estimate"

    $Request = @{
        URI=$query
        Method='POST'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}