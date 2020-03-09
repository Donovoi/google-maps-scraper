@{
    Root = "C:\Users\toor\githubs\google-places-scraper\google-maps-scraper\Get-PlaceInfo.ps1" # Root script to package. This is the main entry point for the package. 
    OutputPath = "C:\Users\toor\githubs\google-places-scraper\google-maps-scraper\out" # The output directory for the packaging process. 
    Package = @{
        Enabled = $true # Whether to package as an executable. 
        Obfuscate = $true # Whether to obfuscate the resulting executable. 
        HideConsoleWindow = $false # Whether to hide the console window.  Only valid for console applications.
        DotNetVersion = 'v4.6.2' # The target .NET Framework version. You will need the .NET Developer Pack for this version installed on your machine.  
        FileVersion = '1.0.0' # The output file version
        FileDescription = 'Google Places Scraper' # The output file description
        ProductName = 'Google Places Scraper' # The output file product name
        ProductVersion = '1' # The output file product version.
        Copyright = 'theablecoder' # The output file copyright
        RequireElevation = $true # Whether to require elevation when running the executable. Only valid for console applications. 
        ApplicationIconPath = '' # The path to the application icon to use for the executable. 
        PackageType = 'Console' # The type of executable to generate. Valid values are Service or Console. 
        ServiceName = "" # The name of the service if the package type is Service. 
        ServiceDisplayName = "" # The display name of the service if the package type is Service. 
        PowerShellCore = $false # Whether to bundle the PowerShell Core runtime within your executable. 
        HighDPISupport = $false  # Whether to enable high DPI support for WinForm applications
        PowerShellArguments = '-NoProfile -ExecutionPolicy Bypass' # Sets the arguments for the PowerShell process that is hosted within the executable. You can use arguments like -NoExit, -ExecutionPolicy and -NoProfile.
        Platform = 'x64' # Sets the architecture of the executable. Can be either 'x86' or 'x64'
    }
    Bundle = @{
        Enabled = $true # Whether to bundle multiple PS1s into a single PS1. Always enabled when Package is enabled. 
        Modules = $true # Whether to bundle modules into the package
    }
}
    