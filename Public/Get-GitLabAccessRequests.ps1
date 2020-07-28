Function Get-GitLabGroupAccessRequests {
    <#
    .SYNOPSIS
    Gets all access requests of the given group OR project.
    .DESCRIPTION
    Gets all access requests of the given group OR project.
    .EXAMPLE
    Get-GitLabAccessRequests -GroupId 89
    #>
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = "Group")]
        [ValidateNotNullOrEmpty()]
        $GroupId,
        [Parameter(ParameterSetName = "Project")]
        [ValidateNotNullOrEmpty()]
        $ProjectId
    )

    if ($PSBoundParameters.ContainsKey('GroupId')) {
        $Request = @{
            URI="/groups/$GroupId/access_requests"
            Method='GET'
        }

        Invoke-GitLabAPI -Request $Request -ObjectType 'GitLab.Request.Access'
        Remove-Variable $Request
    }
    if ($PSBoundParameters.ContainsKey('ProjectId')) {
        $Request = @{
            URI="/groups/$GroupId/access_requests"
            Method='GET'
        }
    }

    

    
}