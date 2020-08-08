$Issues = Get-GitLabIssue -ProjectId 3154 -Search "API" -State 'opened' -Verbose

for ($i = 0; $i -lt $Issues.Length; $i++) {
    foreach ($Issue in $Issues[$i])
    {
        Update-GitLabIssue -ProjectId 3154 -IssueIid $Issue.iid -AddLabels "Status: To Do"
    }
}
