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
        [Parameter(Mandatory = $true)] $ProjectId,
        [Parameter(switch)] $Issues,
        [Parameter(switch)] $MergeRequests,
        [Parameter(switch)] $Snippets
    )
    
    $awardEmojis = @{}

    if ($Issues) {}
    if ($MergeRequests) {}
    if ($Snippets) {}
}