# SYNOPSIS
Merge Multiple CSV Files into a single one.

# DESCRIPTION
Merge multiple csv files into a single csv file. Useful for taking multiple pieces of data and consolidating into a larger sheet.

# PARAMETERS
## SourcePath
- String
- Path to the CSV files to merge
## DestinationPath
- String
- Path to output merged file

## LogPath
- String
- Path to place log file
- Defaults to `$env:WINDIR\Logs`


# EXAMPLES
`Merge-CSV.ps1 -SourcePath "C:\Scripts\Csvs" -DestinationPath "C:\Scripts\Output"`


# CONTRIBUTE
