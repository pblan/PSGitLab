Function Set-GitLabIssueTimer {
    <#
    .SYNOPSIS
    Sets an estimated time of work for this issue.
    .DESCRIPTION
    Sets an estimated time of work for this issue.
    .EXAMPLE
    Set-GitLabIssueTimer -ProjectId 3154 -Issue 8 -Duration "3h30min"
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid,
        [Parameter(Mandatory = $true)]
        [ValidatePattern('^\d*h\d*min$')]
        $Duration
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/time_estimate?duration=$Duration"

    $Request = @{
        URI=$query
        Method='POST'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}