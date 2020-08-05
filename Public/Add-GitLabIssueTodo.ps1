Function Add-GitLabIssueTodo {
    <#
    .SYNOPSIS
    Manually creates a todo for the current user on an issue.
    .DESCRIPTION
    Manually creates a todo for the current user on an issue.
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
    
    $query = "/projects/$ProjectId/issues/$IssueIid/todo"

    $Request = @{
        URI=$query
        Method='POST'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}