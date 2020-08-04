Function Add-GitLabAwardEmoji {
    <#
    .SYNOPSIS
    Awards a given resource a new emoji.
    .DESCRIPTION
    Awards a given resource a new emoji.
    .EXAMPLE
    Get-GitLabAwardEmoji -SnippetId 48 -ProjectId 3154
    #>  
    [CmdletBinding()]
    param (
        [Parameter(ParameterSetName = "Issue", Mandatory = $true)]
        [Parameter(ParameterSetName = "IssueComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "MergeRequest", Mandatory = $true)]
        [Parameter(ParameterSetName = "MergeRequestComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "Snippet", Mandatory = $true)]
        [Parameter(ParameterSetName = "SnippetComment", Mandatory = $true)]
        $ProjectId,
        [Parameter(ParameterSetName = "Issue", Mandatory = $true)] 
        [Parameter(ParameterSetName = "IssueComment", Mandatory = $true)]
        $IssueIid,
        [Parameter(ParameterSetName = "MergeRequest", Mandatory = $true)]
        [Parameter(ParameterSetName = "MergeRequestComment", Mandatory = $true)]
        $MergeRequestIid,
        [Parameter(ParameterSetName = "Snippet", Mandatory = $true)] 
        [Parameter(ParameterSetName = "SnippetComment", Mandatory = $true)]
        $SnippetId,
        [Parameter(ParameterSetName = "IssueComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "MergeRequestComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "SnippetComment", Mandatory = $true)]
        $NoteId,
        [Parameter(ParameterSetName = "Issue", Mandatory = $true)]
        [Parameter(ParameterSetName = "IssueComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "MergeRequest", Mandatory = $true)]
        [Parameter(ParameterSetName = "MergeRequestComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "Snippet", Mandatory = $true)]
        [Parameter(ParameterSetName = "SnippetComment", Mandatory = $true)]
        $Name
    )

    # Non-comment award section
    if ($PSBoundParameters.ContainsKey('IssueIid') -and !$PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/issues/$IssueIid/award_emoji?name=$Name"
            Method='POST'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }

    if ($PSBoundParameters.ContainsKey('MergeRequestIid') -and !$PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/merge_requests/$MergeRequestIid/award_emoji?name=$Name"
            Method='POST'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }

    if ($PSBoundParameters.ContainsKey('SnippetId') -and !$PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/snippets/$SnippetId/award_emoji?name=$Name"
            Method='POST'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }

    # Comment award section 
    if ($PSBoundParameters.ContainsKey('IssueIid') -and $PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/issues/$IssueIid/notes/$NoteId/award_emoji?name=$Name"
            Method='POST'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }

    if ($PSBoundParameters.ContainsKey('MergeRequestIid') -and $PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/merge_requests/$MergeRequestIid/notes/$NoteId/award_emoji?name=$Name"
            Method='POST'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }

    if ($PSBoundParameters.ContainsKey('SnippetId') -and $PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/snippets/$SnippetId/notes/$NoteId/award_emoji?name=$Name"
            Method='POST'
        }

        $response = Invoke-GitLabAPI -Request $Request
    }
    
    $response
}