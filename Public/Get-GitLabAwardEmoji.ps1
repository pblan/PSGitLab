Function Get-GitLabAwardEmoji {
    <#
    .SYNOPSIS
    Gets all received award emojis. Requires project ID and award emoji source.
    .DESCRIPTION
    Gets all received award emojis. Requires project ID and award emoji source.
    .EXAMPLE
    Get-GitLabAwardEmoji -ProjectId 2 -Issues -Snippets
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
        [Parameter(ParameterSetName = "Issue", Mandatory = $false)]
        [Parameter(ParameterSetName = "IssueComment", Mandatory = $false)]
        [Parameter(ParameterSetName = "MergeRequest", Mandatory = $false)]
        [Parameter(ParameterSetName = "MergeRequestComment", Mandatory = $false)]
        [Parameter(ParameterSetName = "Snippet", Mandatory = $false)]
        [Parameter(ParameterSetName = "SnippetComment", Mandatory = $false)]
        $AwardId = "",
        [Parameter(ParameterSetName = "IssueComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "MergeRequestComment", Mandatory = $true)]
        [Parameter(ParameterSetName = "SnippetComment", Mandatory = $true)]
        $NoteId
    )

    $awardEmojis = @{}

    # Non-comment award section
    if ($PSBoundParameters.ContainsKey('IssueIid') -and !$PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/issues/$IssueIid/award_emoji/$AwardId"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
        $awardEmojis = $awardEmojis, $response
    }

    if ($PSBoundParameters.ContainsKey('MergeRequestIid') -and !$PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/merge_requests/$MergeRequestIid/award_emoji/$AwardId"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
        $awardEmojis = $awardEmojis, $response
    }

    if ($PSBoundParameters.ContainsKey('SnippetId') -and !$PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/snippets/$SnippetId/award_emoji/$AwardId"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
        $awardEmojis = $awardEmojis, $response
    }

    # Comment award section 
    if ($PSBoundParameters.ContainsKey('IssueIid') -and $PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/issues/$IssueIid/notes/$NoteId/award_emoji/$AwardId"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
        $awardEmojis = $awardEmojis, $response

    }

    if ($PSBoundParameters.ContainsKey('MergeRequestIid') -and $PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/merge_requests/$MergeRequestIid/notes/$NoteId/award_emoji/$AwardId"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
        $awardEmojis = $awardEmojis, $response
        
    }

    if ($PSBoundParameters.ContainsKey('SnippetId') -and $PSBoundParameters.ContainsKey('NoteId')) {
        $Request = @{
            URI="/projects/$ProjectID/snippets/$SnippetId/notes/$NoteId/award_emoji/$AwardId"
            Method='GET'
        }

        $response = Invoke-GitLabAPI -Request $Request #-ObjectType 'GitLab.Award'
        $awardEmojis = $awardEmojis, $response
    }

    $awardEmojis | Format-Table | Out-String | Write-Host
}
    

    