function Write-Log
{
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $true,
      ValueFromPipelineByPropertyName = $true)]
    [ValidateNotNullOrEmpty()]
    [Alias("LogContent")]
    [string]$Message,

    [Parameter(Mandatory = $false)]
    [Alias('LogPath')]
    [string]$Path = 'C:\Logs\scrape-logs.log',

    # [Parameter(Mandatory = $false)]
    # [ValidateSet("Error","Warn","Info")]
    # [string]$Level = "Info",

    [Parameter(Mandatory = $false)]
    [switch]$NoClobber
  )

  begin
  {
    # Set VerbosePreference to Continue so that verbose messages are displayed.
    # $ErrorActionPreference = "silentlycontinue";
    # $DebugPreference = "silentlycontinue";
    # $VerbosePreference = "silentlycontinue";
    # $WarningPreference = "silentlycontinue";
    # $ConfirmPreference = "None";
  }
  process
  {

    # If the file already exists and NoClobber was specified, do not write to the log.
    if ((Test-Path $Path) -and $NoClobber) {
      Write-Error "Log file $Path already exists, and you specified NoClobber. Either delete the file or specify a different name."
      return
    }

    # If attempting to write to a log file in a folder/path that doesn't exist create the file including the path.
    elseif (!(Test-Path $Path)) {
      Write-Output "Creating $Path."
      $NewLogFile = New-Item $Path -Force -ItemType File
    }

    else {
      # Nothing to see here yet.
    }

    # Format Date for our Log File
    $FormattedDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Write message to error, warning, or verbose pipeline and specify $LevelText
    # switch ($Level) {
    #   'Error' {
    #     Write-Error $Message
    #     $LevelText = 'ERROR:'
    #   }
    #   'Warn' {
    #     Write-Warning $Message
    #     $LevelText = 'WARNING:'
    #   }
    #   'Info' {
    #     Write-Verbose $Message
    #     $LevelText = 'INFO:'
    #   }
    # }
    # Write log entry to $Path
    "$FormattedDate $LevelText $Message" | Out-File -FilePath $Path -Append
  }
  end
  {
  }
}
