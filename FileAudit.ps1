$directoryPath = "C:\AuditDirectory"
$logFilePath = "C:\AuditLog.txt"

# Check if log file exists, create it if it doesn't
if (-not (Test-Path $logFilePath)) {
    New-Item -ItemType File -Path $logFilePath
}

# Get initial file count and write to log
$initialFileCount = (Get-ChildItem $directoryPath -Recurse | Measure-Object).Count
Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): Initial file count is $initialFileCount." | Out-File $logFilePath -Append

# Monitor directory for changes
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $directoryPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

$createdAction = {
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): File $($Event.SourceEventArgs.Name) was created." | Out-File $logFilePath -Append
}

$deletedAction = {
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): File $($Event.SourceEventArgs.Name) was deleted." | Out-File $logFilePath -Append
}

$changedAction = {
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): File $($Event.SourceEventArgs.Name) was changed." | Out-File $logFilePath -Append
}

$renamedAction = {
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): File $($Event.SourceEventArgs.OldName) was renamed to $($Event.SourceEventArgs.Name)." | Out-File $logFilePath -Append
}

Register-ObjectEvent $watcher "Created" -Action $createdAction
Register-ObjectEvent $watcher "Deleted" -Action $deletedAction
Register-ObjectEvent $watcher "Changed" -Action $changedAction
Register-ObjectEvent $watcher "Renamed" -Action $renamedAction

# Keep the script running indefinitely
while ($true) {
    Start-Sleep -Seconds 60
}
