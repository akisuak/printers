

# Get the printer objects from WMI:
$Printers = Get-CimInstance -ClassName Win32_Printer

# Display the number of printers defined:
# '{0} Printers defined on this system' -f $Printers.Count

#Get the "\\PS5\Follow-me" printer:
$Printer = $Printers | Where-Object Name -eq "\\PS5\Follow-me"

# Display the printer's details:
# $Printer | Format-Table -AutoSize

#Print a test page:
Invoke-CimMethod -InputObject $Printer -MethodName PrintTestPage


