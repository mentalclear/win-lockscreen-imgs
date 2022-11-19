$imagesSourcePath = $env:LOCALAPPDATA + "\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\"
$outboxPath = [String]$(Get-Location) + "\Outbox\"

function Test-PowershellIsNew {	
	if ($PSVersionTable.PSVersion -match "5.*") {
		return $false
	}	
	return $true
}

function Test-ImageSizeGreater300k {
	param ($File)
	if ($File.Length -gt 300000) { 
		return $true 
	}
	return $false
}

function Convert-Image {
	param ($File) 
	if (Test-PowershellIsNew) { $File = $File.BaseName }	
	Copy-Item -Path $imagesSourcePath$File -Destination $outboxPath$File".jpg"	
}

function Get-LockScreenImages {    
	$(Get-ChildItem $imagesSourcePath) | ForEach-Object {
		if ($(Test-ImageSizeGreater300k -File $_)) { Convert-Image -File $_ }
	}
}

Get-LockScreenImages
