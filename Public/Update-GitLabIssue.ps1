Function Update-GitLabIssue {
    <#
    .SYNOPSIS
    Updates an existing project issue.
    .DESCRIPTION
    Updates an existing project issue.
    .EXAMPLE

    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter(Mandatory = $true)]
        $IssueIid,
        [Parameter()]
        $Title,
        [Parameter()]
        $Description,
        [Parameter()]
        [switch]
        $Confidential,
        [Parameter()]
        [int[]]
        $AssigneeIds,
        [Parameter()]
        $MilestoneId,
        [Parameter()]
        $Labels,
        [Parameter()]
        $AddLabels,
        [Parameter()]
        $RemoveLabels,
        [Parameter()]
        [ValidateSet('close', 'reopen')]
        $StateEvent,
        [Parameter()]
        [datetime]
        $UpdatedAt,
        [Parameter()]
        [datetime]
        $DueDate,
        [Parameter()]
        $Weight,
        [switch]
        $DiscussionLocked,
        [Parameter()]
        $EpicId,
        [Parameter()]
        $EpicIid
    )

    # Start of request
    $IssueIid = 7
    $query = "/projects/$ProjectId/issues/$IssueIid\?"
    Write-Host $query


    # Concatenating query

    Write-Verbose "PSBoundParameter: $($PSBoundParameters.GetEnumerator())"

    foreach ($param in $PSBoundParameters.GetEnumerator()) {
        switch ($param.Key) {
            'Title' { $query = $query + "&title=$($param.Value)" }
            'Description' { $query = $query + "&description=$($param.Value)" }
            'Confidential' { $bool = $param.Value.ToString().ToLower() ; $query = $query + "&confidential=$($bool)" }
            'AssigneeIds' { $assignees = $param.Value -join "," ; $query = $query + "&assignee_ids=$($assignees)" }
            'MilestoneId' { $query = $query + "&milestone_id=$($param.Value)" }
            'Labels' { $query = $query + "&labels=$($param.Value)" }
            'AddLabels' { $query = $query + "&add_labels=$($param.Value)" }
            'RemoveLabels' { $query = $query + "&remove_labels=$($param.Value)" }
            'StateEvent' { $query = $query + "&state_event=$($param.Value)" }
            'UpdatedAt' { $date = $param.Value.ToString("yyyy-MM-dd\THH\:mm\:ss") ; $query = $query + "&updated_at=$($date)" }
            'DueDate' { $date = $param.Value.ToString("yyyy-MM-dd") ; $query = $query + "&due_date=$($date)" }
            'Weight' { $query = $query + "&weight=$($param.Value)" }
            'DiscussionLocked' { $bool = $param.Value.ToString().ToLower() ; $query = $query + "&discussion_locked=$($bool)" }
            'EpicId' { $query = $query + "&epic_id=$($param.Value)" }
            'EpicIid' { $query = $query + "&epic_iid=$($param.Value)" }
            Default {}
        }
    }

    # Remove Whitespace

    $query = $query -replace '\s', '%20'

    $Request = @{
        URI=$query
        Method='PUT'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}

