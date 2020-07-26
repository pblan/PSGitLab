Function Get-GitLabProjectAccessRequests {
    <#
    .SYNOPSIS
    Gets all access requests of the given project.
    .DESCRIPTION
    Gets all access requests of the given project.
    .EXAMPLE
    Get-GitLabProjectAccessRequests -GroupId 3154
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        $ProjectId
    )

    $Request = @{
        URI="/projects/$ProjectId/access_requests"
        Method='GET'
    }

    Invoke-GitLabAPI -Request $Request -ObjectType 'GitLab.Request.Access'
}

Write-Host (Get-GitLabProjectAccessRequests -ProjectId 3154)