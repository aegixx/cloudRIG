# Create new temp folder
mkdir Z:\TEMP\
Invoke-Expression -Command "icacls Z:\TEMP /grant 'Everyone:(OI)(CI)F'"

Set-ItemProperty -Path HKCU:\Environment -Name TEMP -Value Z:\TEMP
Set-ItemProperty -Path HKCU:\Environment -Name TMP -Value Z:\TEMP

# Create a new Pagefile for Ephemeral Drive
$computersys = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges;
$computersys.AutomaticManagedPagefile = $False;
$computersys.Put();
$pagefile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name like '%pagefile.sys'";
$pagefile.Name = "Z:\pagefile.sys"
$pagefile.InitialSize = 32768;
$pagefile.MaximumSize = 131072;
$pagefile.Put();

# Disable the C drive
$pagefile = Get-WmiObject -Query "Select * From Win32_PageFileSetting Where Name like 'C:\\pagefile.sys'";
$pagefile.Delete();

