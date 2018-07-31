
#powershell script to remotely reboot networked HP and Xerox printers
#ip values in plain text file printers.txt in the same directory as the script. ip's on separate lines.
#philgman@gmail.com 

$SNMP = new-object -ComObject olePrn.OleSNMP

$ErrorActionPreference = "Continue"
<#Available choices for error action preference:
•SilentlyContinue – error messages are suppressed and execution continues.
•Stop – forces execution to stop, behaving like a terminating error.
•Continue - the default option. Errors will display and execution will continue.
•Inquire – prompt the user for input to see if we should proceed.
•Ignore – (new in v3) – the error is ignored and not logged to the error stream. Has very restricted usage scenarios.
#>

#reset the $error[0].Exception value on start and repeat on each loop
$error.clear()

#read from list
#return "Could not contact $_" if no response to ping
#return "Failed $_" if it connects but can not set the value
function setsnmp
{
$SNMP.open("$_","private",1,6000)
$SNMP.Set(".1.3.6.1.2.1.43.5.1.1.3.1",4)
}

Get-Content printers.txt | ForEach-Object {
if (Test-Connection $_ -Count 1 -Quiet) #test connection to ip with single ping
{
setsnmp
}
else {
Write-Output "Could not contact $_"
}
if ( $error[0].Exception -match "Exception calling")
{
Write-Output "Failed $_"
}
$error.clear()
}

#send snmp value
# setting the integer value "4" to oid ".1.3.6.1.2.1.43.5.1.1.3.1" using the "private" community name forces the printer to reboot 


