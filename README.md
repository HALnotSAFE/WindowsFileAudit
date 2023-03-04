# WindowsFileAudit
This script audits if any changes were made to a folder. This is useful in enterprise environments to see traffic in a directory. 

To use this script, open the FileAudit.PS1 file and at the top you will see this block of code: 

$directoryPath = "C:\AuditDirectory"
$logFilePath = "C:\AuditLog.txt"

Change the first line to use the directory of your choice and chnage the second line to define where the logfile is stored. 

Example: 

$directoryPath = "D:\MECMDP"
$logFilePath = "E:\Logs\MECMDPAuditLog.txt"

In this example, I am auditing any changes made to the MECMDP folder on the D:\ drive and logging those changes to E:\Logs as a .txt file named MECMDPAuditLog.txt.
