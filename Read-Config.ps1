# This Script will read the Json config. If none can be found, it will automatically create one and prompt for the values.

function Read-Config {
  $ErrorActionPreference = "silentlycontinue";
  $DebugPreference = "silentlycontinue";
  $VerbosePreference = "silentlycontinue";
  $WarningPreference = "silentlycontinue";
  $ConfirmPreference = "None";

  try {
    Write-Log -Message "Trying to Read configuration file.";
    try {
      Write-Log -Message 'Getting content of config.json'
      $config = Get-Content -Path ".\config.json" -ErrorAction 'Stop' | ConvertFrom-Json
      $config = [pscustomobject]@{
        apiKey = $config.apiKey;
      }
      # return $config
    } catch {
      throw "Can't find the JSON configuration file. Creating a new one"
    }
    $config
    foreach ($configprop in $config.PsObject.Properties) {
      switch ($configprop.Name) {
        apiKey { New-Variable -Name apiKey -Visibility Public -Value $configprop.Value -Force -Passthru -Option AllScope -Scope Global; }
        Default {}
      }
    }
    Write-Log -Message "Stored config.json found."
  }
  catch {
    Write-Log -Message "Creating Configuration"
    $apiKeyInput = Read-Host "Please enter your Google Places API key";
    $jsonString = @"
  {   
"apiKey": "$apiKeyInput"
  }  
"@
    $config = $jsonString | ConvertFrom-Json
    Write-Log -Message "Creating config.json file";
    $config | ConvertTo-Json | Set-Content -Path ".\config.json"

    foreach ($configprop in $config.PsObject.Properties) {

      switch ($configprop.Name) {
        apiKey { New-Variable -Name apiKey -Visibility Public -Value $configprop.Value -Force -Passthru -Option AllScope -Scope Global; }
        Default {}
      }
    }
  }
}
