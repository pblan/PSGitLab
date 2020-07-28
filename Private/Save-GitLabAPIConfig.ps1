Function Save-GitLabAPIConfig {
   <#
   .Synopsis
      Used to store information about your GitLab instance.
   .DESCRIPTION
      Used to store information about your GitLab instance.
   .EXAMPLE
      Save-GitLabAPIConfig -Domain https://git-ce.rwth-aachen.de -Token "AaAHJvhcjbdvhdv6"
   .NOTES
      Stores .xml in $env:appdata\PSGitLab\
   #>
   [CmdletBinding()]
   param(
      [Parameter(Mandatory=$true)] 
      [ValidateNotNullOrEmpty()] 
      $Token,
      [Parameter(Mandatory=$true)]
      [ValidateNotNullOrEmpty()] 
      $Domain,
      [Parameter()]
      [ValidateNotNullOrEmpty()]
      $ConfigPath = "$env:appdata\PSGitLab\PSGitLabConfig.xml"
   )

   $parameters = @{
      Token = ConvertTo-SecureString -String $Token -AsPlainText -Force
      Domain = $Domain;
   }

   if (!(Test-Path (Split-Path $ConfigPath))) {
      New-Item -ItemType Directory -Path (Split-Path $ConfigPath) | Out-Null
   }

   $parameters | Export-Clixml -Path $ConfigPath
   Remove-Variable Parameters
}