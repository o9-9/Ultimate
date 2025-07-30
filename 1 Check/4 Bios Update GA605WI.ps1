    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

# Robust PowerShell Script to Search Motherboard Info for ROG Zephyrus G16 (2024) GA605
try {
    # Get motherboard information using CIM (modern way)
    $baseboard = Get-CimInstance -ClassName Win32_BaseBoard

    $manufacturer = $baseboard.Manufacturer
    $product = $baseboard.Product
    $serial = $baseboard.SerialNumber

    if ($product) {
        # Construct a detailed search query
        $query = "$manufacturer $product $serial ROG Zephyrus G16 GA605"
        $encodedQuery = [System.Web.HttpUtility]::UrlEncode($query)
        $url = "https://www.google.com/search?q=$encodedQuery"
        Start-Process $url
        Write-Output "Searching for motherboard info: $query"
    } else {
        Write-Warning "Could not retrieve motherboard information."
    }
}
catch {
    Write-Error "An error occurred: $_"
}
