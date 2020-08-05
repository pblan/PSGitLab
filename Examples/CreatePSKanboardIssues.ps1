$URL = 'https://docs.kanboard.org/en/latest/api/index.html'
$Content = Invoke-WebRequest $URL

# Scraping all the procedures from the Kanboard API Overview Page

$Pattern = '<li class="toctree-l2"><a class="reference internal" href="(?<Link>.*).html">(?<Name>.*) Procedures</a></li>'
$AllMatches = ($Content | Select-String $Pattern -AllMatches).Matches

Write-Host ($AllMatches | Format-List | Out-String)

$ProcedureList = foreach ($Match in $AllMatches)
{
    [PSCustomObject]@{
        'Name' = ($Match.Groups.Where{$_.Name -like 'Name'}).Value + " Procedures"
        'Link' = "https://docs.kanboard.org/en/latest/api/" + ($Match.Groups.Where{$_.Name -like 'Link'}).Value + ".html"
        'Requests' = @()
    }
}

$ProcedureList = $ProcedureList | Sort-Object -Property Name -Unique

# Getting the procedure specific requests

foreach ($Procedure in $ProcedureList)
{
    $TempContent = Invoke-WebRequest $Procedure.Link
    $AllMatches = ($TempContent | Select-String '<li class="toctree-l3"><a class="reference internal" href="#\w*">(?<Request>.*)</a></li>' -AllMatches).Matches
    $Procedure.Requests = $Procedure.Requests + ($AllMatches.Groups.Where{$_.Name -like 'Request'}).Value

    Write-Host ($Procedure | Format-Table | Out-String)
    $Description = "See: $($Procedure.Link)" + "%0D%0A"
    $Description += "%0D%0A"
    foreach ($Request in $Procedure.Requests)
    {
        $Description += "- [ ] " + $Request + "%0D%0A"
    }
    
    Add-GitLabIssue -ProjectId 3198 -Title $Procedure.Name -Description $Description -MilestoneId 748 -Label "New Function" | Out-Null
}