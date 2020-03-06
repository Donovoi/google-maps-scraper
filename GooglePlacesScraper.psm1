#import all functions
$Public  = @( Get-ChildItem -Path $PSScriptRoot\*.ps1 -ErrorAction SilentlyContinue )

#Dot source the files
Foreach($import in @($Public))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}
