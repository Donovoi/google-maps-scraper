function Get-PlaceInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]   $URL
        # [Parameter(Mandatory=$false,
		# ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]   $Radius = 14
    )
    
    begin {
        #Import required Modules
        $ErrorActionPreference = "stop";
        # $DebugPreference = "continue";
        # $VerbosePreference = "continue";
        # $WarningPreference = "continue";
    
        Write-Output "All Logging and information will be in C:\Logs\scrape-logs.log";
        #Create/Read Config file
        Read-Config | Out-Null;
    
        Write-Log -Message "Checking for required modules";
        if ($PSVersionTable.PSVersion -lt '6.2') {
          Install-PackageProvider -Name NuGet -Force | Out-Null;
        }
    
        if (-not (Get-InstalledModule PoshGMaps -ErrorAction SilentlyContinue)) {
          Write-Log -Message "Installing PoshGMaps";
          Install-Module -Name PoshGMaps -Force -AllowClobber | Out-Null;
          Import-Module -Name PoshGMaps;
        };

        Import-Module -Name PoshGMaps;

    }
    
    process {
        
    }
    
    end {
        
    }
}