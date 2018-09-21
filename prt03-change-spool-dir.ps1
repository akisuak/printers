

# 1. Load the System.Printing namespace and classes

Add-Type -AssemblyName System.Printing 

# 2. Define the required permissions—that is, the ability to administrate the server

$Permissions = [System.Printing.PrintSystemDesiredAccess]::AdministrateServer

# 3. Create a PrintServer object with the required permissions

$Ps = New-Object  -TypeName System.Printing.PrintServer -ArgumentList $Permissions

# 4. Update the default spool folder path

$Newpath = 'D:\Spool' 
$Ps.DefaultSpoolDirectory = $Newpath 

# 5. Commit the change

$Ps.Commit() 

# 6. Restart the Spooler to accept the new folder

Restart-Service -Name Spooler

# 7. Once the Spooler has restarted, view the results

New-Object -TypeName System.Printing.PrintServer | Format-Table -Property Name, DefaultSpoolDirectory 



