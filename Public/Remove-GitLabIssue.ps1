Function Remove-GitLabIssue {
    <#
    .SYNOPSIS
    Removes an existing project issue.
    .DESCRIPTION
    Removes an existing project issue.
    .EXAMPLE

    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid"

    $Request = @{
        URI=$query
        Method='DELETE'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}

