param(
    [CmdletBinding()]
    [parameter(Mandatory)]
    [ValidateScript({if(Test-Path -Path "$_"){$true} else {Write-Warning "Path $_ is not valid."}})]
    [string]
    $SourcePath,
    [parameter(Mandatory)]
    [ValidateScript({if(Test-Path -Path "$_"){$true} else {New-Item -Path "$_" -ItemType Directory -Force}})]
    [string]
    $DestinationPath,
    [parameter(Mandatory = $false)]
    [string]
    $LogPath = "$env:WINDIR\Logs"
)

begin{
    #-- BEGIN: Executes First. Executes once. Useful for setting up and initializing. Optional
    if($LogPath -match '\\$'){
        $LogPath = $LogPath.Substring(0,($LogPath.Length - 1))
    }
    Write-Verbose -Message "Creating log file at $LogPath."
    #-- Use Start-Transcript to create a .log file
    #-- If you use "Throw" you'll need to use "Stop-Transcript" before to stop the logging.
    #-- Major Benefit is that Start-Transcript also captures -Verbose and -Debug messages.
    Start-Transcript -Path "$LogPath\NameofScript.log"
}
process{
    #-- PROCESS: Executes second. Executes multiple times based on how many objects are sent to the function through the pipeline. Optional.
    Write-Verbose -Message "Getting all CSV Files at $SourcePath"
    $CSVs = Get-ChildItem -Path "$SourcePath" -Filter "*.csv" 
    Write-Verbose -Message "Checking if more than one .csv file was detected."
    if($null -ne $CSVs){
        Write-Verbose -Message "Found at $($CSVs.Count) .csv files."
        if($CSVs.Count -gt 1){
            Write-Verbose -Message "Importing .csv files and merging into one (1) at $DestinationPath."
            $CSVs | Select-Object -ExpandProperty FullName | Import-Csv | Export-Csv -Path "$($DestinationPath)\merged_$(Get-Date -Format yyyy-MM-dd_hh-mm).csv" -NoTypeInformation -Append
        } else {
            Write-Warning "Only one CSV file detected. Nothing to merge."
        }
    } else {
        Write-Warning "No CSV files found in path $SourcePath."
    }
}
end{
    # END: Executes Once. Executes Last. Useful for all things after process, like cleaning up after script. Optional.
    Stop-Transcript
}




