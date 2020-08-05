Function Move-GitLabIssue {
    <#
    .SYNOPSIS
    Moves an existing project issue to another project.
    .DESCRIPTION
    Moves an existing project issue to another project.
    .EXAMPLE
    Move-GitLabIssue -ProjectId 3154 -IssueIid 131 -ToProjectId 3198
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