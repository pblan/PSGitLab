Function Add-GitLabIssueTime {
    <#
    .SYNOPSIS
    Adds spent time for this issue.
    .DESCRIPTION
    Adds spent time for this issue.
    .EXAMPLE
    Add-GitLabIssueTime -ProjectId 3154 -Issue 8 -Duration "3h30min"
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
    
    $query = "/projects/$ProjectId/issues/$IssueIid/add_spent_time?duration=$Duration"

    $Request = @{
        URI=$query
        Method='POST'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}