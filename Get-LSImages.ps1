[String]$currentPath = Get-Location
$inboxPath = $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\"
$outboxPath = $currentPath + "\Outbox\"
$inboxContent = Get-ChildItem $inboxPath 

function Test-PwshIsNew {	
	if ($PSVersionTable.PSVersion -match "5.*") {
		return $false
	}	
	return $true
}

function Test-ImageSizeGreater300k {
	param ($file)
	if ($file.Length -gt 300000) { 
		return $true 
	}
	return $false
}

function Convert-Image {
	param ($file) 
	if (Test-PwshIsNew) { $file = $file.BaseName }	
	Copy-Item -Path $inboxPath$file -Destination $outboxPath$file".jpg"	
}

function Get-LSImages {    
	$inboxContent | ForEach-Object {
		if ($(Test-ImageSizeGreater300k -File $_)) { Convert-Image -File $_ }
	}
}

Get-LSImages
