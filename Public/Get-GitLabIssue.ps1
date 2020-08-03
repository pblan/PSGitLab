Function Get-GitLabIssue {
    <#
    .SYNOPSIS
    Gets all issues specified by given parameters. No parameters result in all your issues.
    .DESCRIPTION
    Gets all issues specified by given parameters. No parameters result in all your issues.
    .EXAMPLE
    Get-GitLabIssue -ProjectId 3154 -CreatedAfter (Get-Date (Get-Date).AddDays(-1))
    #>  
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = "Project", Mandatory = $true)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $true)]
        $ProjectId,
        [Parameter(ParameterSetName = "Group", Mandatory = $true)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $true)]
        $GroupId,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [int[]]
        $IssueIid,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [ValidateSet('all','open','closed')]
        $State,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [String[]]
        $Label,         # 'None', 'Any' and 'No+Label' possible
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $Milestone,     # 'None'and 'Any' possible
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [ValidateSet('all','created_by_me','assigned_to_me')]
        $Scope,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $AuthorId,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $AuthorName,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $AssigneeId,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $AssigneeName,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $ReactionEmoji, # 'None' and 'Any' are possible
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $Weight,        # 'None' and 'Any' are possible
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [ValidateSet('created_at','updated_at','priority','due_date','relative_postion','label_priority','milestone_due','popularity','weight')]
        $OrderBy,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [ValidateSet('asc','desc')]
        $Sort,
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $true)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $true)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $true)]
        $Search,
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [ValidateSet('title','description','title,description')]
        $In,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [datetime]
        $CreatedAfter,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [datetime]
        $CreatedBefore,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [datetime]
        $UpdatedAfter,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [datetime]
        $UpdatedBefore,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [switch]
        $Confidential,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        [switch]
        $NonArchived,
        [Parameter(ParameterSetName = "General", Mandatory = $false)]
        [Parameter(ParameterSetName = "GeneralSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Project", Mandatory = $false)]
        [Parameter(ParameterSetName = "ProjectSearch", Mandatory = $false)]
        [Parameter(ParameterSetName = "Group", Mandatory = $false)]
        [Parameter(ParameterSetName = "GroupSearch", Mandatory = $false)]
        $Not # Difficult I guess, still needs work
    )

    if (($null -ne $AssigneeId) -and ($null -ne $AssigneeName)) {
        Write-Warning "$AssigneeId and $AssigneeName are mutually exclusive!"
        return
    }
    if (($null -ne $AuthorId) -and ($null -ne $AuthorName)) {
        Write-Warning "$AuthorId and $AuthorName are mutually exclusive!"
        return
    }

    # Start of request

    if ($null -ne $ProjectId) {
        $query = "/projects/$ProjectId/issues?"
    }

    if ($null -ne $GroupId) {
        $query = "/groups/$GroupId/issues?"
    }

    if (($null -eq $GroupId) -and ($null -eq $ProjectId)) {
        $query = "/issues?"
    }

    # Concatenating query

    Write-Verbose "PSBoundParameter: $($PSBoundParameters.GetEnumerator())"

    foreach ($param in $PSBoundParameters.GetEnumerator()) {
        switch ($param.Key) {
            #'IssueIid' { $query = $query.TrimEnd('?') + "/$IssueIid" ; break}
            'IssueIid' { $issueIids = $param.Value -join "&iids[]=" ; $query = $query + "&iids[]=$($issueIids)" ; break}
            'State' { $query = $query + "&state=$($param.Value)" }
            'Label' { $labels = $param.Value -join "," ; $query = $query + "&labels=$($labels)" }
            'Milestone' { $query = $query + "&milestone=$($param.Value)" }
            'Scope' { $query = $query + "&scope=$($param.Value)" }
            'AuthorId' { $query = $query + "&author_id=$($param.Value)" }
            'AuthorName' { $query = $query + "&author_name=$($param.Value)" }
            'AssigneeId' { $query = $query + "&assignee_id=$($param.Value)" }
            'AssigneeName' { $query = $query + "&assignee_name=$($param.Value)" }
            'ReactionEmoji' { $query = $query + "&my_reaction_emoji=$($param.Value)" }
            'Weight' { $query = $query + "&weight=$($param.Value)" }
            'OrderBy' { $query = $query + "&order_by=$($param.Value)" }
            'Sort' { $query = $query + "&sort=$($param.Value)" }
            'Search' { $query = $query + "&search=$($param.Value)" }
            'In' { $query = $query + "&in=$($param.Value)" }
            'CreatedAfter' { $date = $param.Value.ToString("yyyy-MM-dd\THH\:mm\:ss") ; $query = $query + "&created_after=$($date)" }
            'CreatedBefore' { $date = $param.Value.ToString("yyyy-MM-dd\THH\:mm\:ss") ; $query = $query + "&created_before=$($date)" }
            'UpdatedAfter' { $date = $param.Value.ToString("yyyy-MM-dd\THH\:mm\:ss") ; $query = $query + "&updated_after=$($date)" }
            'UpdatedBefore' { $date = $param.Value.ToString("yyyy-MM-dd\THH\:mm\:ss") ; $query = $query + "&updated_before=$($date)" }
            'NonArchived' { $bool = $param.Value.ToString().ToLower() ; $query = $query + "&non_archived=$($bool)" }
            'Confidential' { $bool = $param.Value.ToString().ToLower() ; $query = $query + "&confidential=$($bool)" }
            'Not' { <# TO DO #>}
            Default {}
        }
    }

    # Remove Whitespace

    $query = $query -replace '\s', '%20'

    Write-Host $query
    $Request = @{
        URI=$query
        Method='GET'
    }

    $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
    $response
}