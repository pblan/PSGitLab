Function Watch-GitLabIssue {
    <#
    .SYNOPSIS
    Subscribes or unsubscribes to an existing project issue.
    .DESCRIPTION
    Subscribes or unsubscribes to an existing project issue.
    .EXAMPLE
    Watch-GitLabIssue -ProjectId 3154 -IssueIid 131 -Subscribe
    #>  
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = "Subscribe", Mandatory = $true)]
        [Parameter(ParameterSetName = "Unsubscribe", Mandatory = $true)]
        $ProjectId,
        [Parameter(ParameterSetName = "Subscribe", Mandatory = $true)]
        [Parameter(ParameterSetName = "Unsubscribe", Mandatory = $true)]
        $IssueIid,
        [Parameter(ParameterSetName = "Subscribe", Mandatory = $true)]
        [switch]
        $Subscribe,
        [Parameter(ParameterSetName = "Unsubscribe", Mandatory = $true)]
        [switch]
        $Unsubscribe
    )

    # Start of request
    
    if ($Subscribe) {
        $query = "/projects/$ProjectId/issues/$IssueIid/subscribe"
    }

    if ($Unsubscribe) {
        $query = "/projects/$ProjectId/issues/$IssueIid/unsubscribe"
    }

    $Request = @{
        URI=$query
        Method='POST'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}