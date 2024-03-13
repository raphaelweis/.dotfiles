if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
}

Set-PSReadLineOption -EditMode vi

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Set the prompt according to: https://learn.microsoft.com/en-us/windows/terminal/tutorials/new-tab-same-directory
function Invoke-Starship-PreCommand {
  $loc = $executionContext.SessionState.Path.CurrentLocation;
  $prompt = "$([char]27)]9;12$([char]7)"
  if ($loc.Provider.Name -eq "FileSystem")
  {
    $prompt += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $host.ui.Write($prompt)
}

Invoke-Expression (&starship init powershell)
