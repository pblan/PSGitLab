Function Approve-GitLabAccess {
    <#
    .SYNOPSIS
    Approves access for a given group or project. Requires corresponding access rights.
    .DESCRIPTION
    Approves access for a given group or project. Requires corresponding access rights.
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
        $Id,
        [Parameter(ParameterSetName = "Group", Mandatory = $true)]
        [Parameter(ParameterSetName = "Project", Mandatory = $true)]
        $UserId
    )

    # Non-comment award section
    if ($PSBoundParameters.ContainsKey('Group')) {
        $Request = @{
            URI="/groups/$Id/access_requests/$UserId/approve"
            Method='PUT'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }

    if ($PSBoundParameters.ContainsKey('Project')) {
        $Request = @{
            URI="/projects/$Id/access_requests/$UserId/approve"
            Method='PUT'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }

    $response
}