Function Move-GitLabIssue {
    <#
    .SYNOPSIS
    MOves an existing project issue to another project.
    .DESCRIPTION
    MOves an existing project issue to another project.
    .EXAMPLE

    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid,
        [Parameter(Mandatory = $true)]
        $ToProjectId
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/move"

    $Request = @{
        URI=$query
        Method='POST'
        ContentType = 'multipart/form-data'
        Form = @{"to_project_id" = "$ToProjectId"}
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}