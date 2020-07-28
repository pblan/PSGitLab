Function Get-GitLabAccessRequest {
    <#
    .SYNOPSIS
    Gets all access requests for a given group or project. Requires corresponding access rights.
    .DESCRIPTION
    Gets all access requests for a given group or project. Requires corresponding access rights.
    .EXAMPLE
    
    #>  
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = "Group", Mandatory = $true)] 
        [switch]
        $Group,
        [Parameter(ParameterSetName = "Project", Mandatory = $true)] 
        [switch]
        $Project,
        [Parameter(ParameterSetName = "Group", Mandatory = $true)]
        [Parameter(ParameterSetName = "Project", Mandatory = $true)]
        $Id
    )

    # Non-comment award section
    if ($PSBoundParameters.ContainsKey('Group')) {
        $Request = @{
            URI="/groups/$Id/access_requests"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
    }

    if ($PSBoundParameters.ContainsKey('Project')) {
        $Request = @{
            URI="/projects/$Id/access_requests"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
    }

    $response
}