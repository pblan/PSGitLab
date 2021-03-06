Function Add-GitLabIssue {
    <#
    .SYNOPSIS
    Creates a new project issue.
    .DESCRIPTION
    Creates a new project issue.
    .EXAMPLE
    Add-GitLabIssue -ProjectId 3154 -Title "Testing Add-GitLabIssue Cmdlet" -Description "Testing"
    #>  
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $ProjectId,
        [Parameter()]
        $IssueIid,
        [Parameter(Mandatory = $true)]
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
        [datetime]
        $CreatedAt,
        [Parameter()]
        [datetime]
        $DueDate,
        [Parameter()]
        $MergeRequestToResolveDiscussionsOf,
        [Parameter()]
        $DiscussionToResolve,
        [Parameter()]
        $Weight,
        [Parameter()]
        $EpicId,
        [Parameter()]
        $EpicIid
    )

    # Start of request

    $query = "/projects/$ProjectId/issues?"


    # Concatenating query

    Write-Verbose "PSBoundParameter: $($PSBoundParameters.GetEnumerator())"

    foreach ($param in $PSBoundParameters.GetEnumerator()) {
        switch ($param.Key) {
            'IssueIid' { $query = $query + "&iid=$($param.Value)" }
            'Title' { $query = $query + "&title=$($param.Value)" }
            'Description' { $query = $query + "&description=$($param.Value)" }
            'Confidential' { $bool = $param.Value.ToString().ToLower() ; $query = $query + "&confidential=$($bool)" }
            'AssigneeIds' { $assignees = $param.Value -join "," ; $query = $query + "&assignee_ids=$($assignees)" }
            'MilestoneId' { $query = $query + "&milestone_id=$($param.Value)" }
            'Labels' { $query = $query + "&labels=$($param.Value)" }
            'CreatedAt' { $date = $param.Value.ToString("yyyy-MM-dd\THH\:mm\:ss") ; $query = $query + "&created_at=$($date)" }
            'DueDate' { $date = $param.Value.ToString("yyyy-MM-dd") ; $query = $query + "&due_date=$($date)" }
            'MergeRequestToResolveDiscussionsOf' { $query = $query + "&merge_request_to_resolve_discussions_of=$($param.Value)" }
            'DiscussionToResolve' { $query = $query + "&discussion_to_resolve=$($param.Value)" }
            'Weight' { $query = $query + "&weight=$($param.Value)" }
            'EpicId' { $query = $query + "&epic_id=$($param.Value)" }
            'EpicIid' { $query = $query + "&epic_iid=$($param.Value)" }
            Default {}
        }
    }

    # Remove Whitespace

    $query = $query -replace '\s', '%20'

    $Request = @{
        URI=$query
        Method='POST'
    }

    $response = Invoke-GitLabAPI -Request $Request
    $response
}

