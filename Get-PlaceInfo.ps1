function Get-PlaceInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]   $URL,
        [Parameter(Mandatory=$false,
		ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]   $Radius = 1000
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
    $output.results.place_id

    }
    
    end {
        
    }
}