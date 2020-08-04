$URL = 'https://docs.gitlab.com/ee/api/api_resources.html'
$Content = Invoke-WebRequest $URL

# Scraping all the resources from the GitLab API Resources List

$Pattern = '<td style=text-align:left>\n*<a href=(?<Link>.*).html>(?<Name>.*)</a>'
$AllMatches = ($Content | Select-String $Pattern -AllMatches).Matches

$ResourceList = foreach ($Resource in $AllMatches)
{
    [PSCustomObject]@{
        'Name' = ($Resource.Groups.Where{$_.Name -like 'Name'}).Value
        'Link' = "https://docs.gitlab.com/ee/api/" + ($Resource.Groups.Where{$_.Name -like 'Link'}).Value + ".html"
        'Title' = ""
    }
}

$ResourceList = $ResourceList | Sort-Object -Property Name -Unique

# Getting the actual titles and creating issues

foreach ($Resource in $ResourceList)
{
    $TempContent = Invoke-WebRequest $Resource.Link
    $Match = ($TempContent | Select-String '<title>(?<Title>.*) \| GitLab</title>' -AllMatches).Matches | Select-Object -First 1
    $Resource.Title = ($Match.Groups.Where{$_.Name -like 'Title'}).Value

    Add-GitLabIssue -ProjectId 3154 -Title "$($Resource.Title)" -Description "See: $($Resource.Link)" -MilestoneId "727" -Labels "New Function" | Out-Null
    Write-Host ($Resource | Format-Table | Out-String)
}