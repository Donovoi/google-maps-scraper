function Get-PlaceInfo {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $True,
      ValueFromPipeline = $True,ValueFromPipelinebyPropertyName = $true)] $URL
  )

  begin {
    #Import required Modules
    $ErrorActionPreference = "stop";
    # $DebugPreference = "continue";
    # $VerbosePreference = "continue";
    # $WarningPreference = "continue";

    Import-Module .\GooglePlacesScraper.psm1

    Write-Output "All Logging and information will be in C:\Logs\scrape-logs.log";
    #Create/Read Config file
    Read-Config | Out-Null;
  }

  process {
    #Format URL to usable format
    Write-Log "Getting Search String From URL";
    $SplitURL = ($URL -split "/")[5];
    [regex]$RegexLookUp = '([a-zA-Z0-9])*'
    $SearchString = $RegexLookUp.Matches($SplitURL);

    # Query Google Maps
    Write-Log "Querying Google Maps now..."
    $output = Invoke-RestMethod "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$SearchString&key=$($apiKey)" -Method "GET"

    # Convert Data to appropriate fields
    $places = $output.results.place_id

    Write-Log "Formatting returned data and exporting csv"
    foreach ($place in $places) {
      $placeIdInfo = Invoke-RestMethod "https://maps.googleapis.com/maps/api/place/details/json?place_id=$($place)&key=$($apiKey)" -Method "GET"
      $properties = $placeIdInfo.result;
      $properties | Select-Object Name,types[0],formatted_address,{ ($properties.formatted_address -split ',')[0] },{ ($properties.formatted_address -split ',')[1] },{ ($properties.formatted_address -split ',')[2] },{ ($properties.formatted_address -split ',')[3] },{ ($properties.formatted_address -split ',')[4] },website,formatted_phone_number,{ $properties.plus_code.compound_code },url | Export-Csv -Path "export.csv" -Append -Force
    }
  }

  end {
    Write-Host "All done! Please find export.csv in the same location as the script"
  }
}
