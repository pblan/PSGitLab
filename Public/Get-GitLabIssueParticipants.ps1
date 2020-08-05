Function Get-GitLabIssueParticipants {
    <#
    .SYNOPSIS
    Get all the participants that are related to the issue.
    .DESCRIPTION
    Get all the participants that are related to the issue.
    .EXAMPLE
    Get-GitLabIssueParticipants -ProjectId 3154 -Issue 8
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid
    )

    # Start of request
    
    $query = "/projects/$ProjectId/issues/$IssueIid/participants"

    $Request = @{
        URI=$query
        Method='GET'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}