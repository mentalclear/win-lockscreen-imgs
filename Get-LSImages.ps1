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

function Convert-Images {
	param ($File) 
	if (Test-PwshIsNew) { $File = $File.BaseName }	
	Copy-Item -Path $inboxPath$File -Destination $outboxPath$File".jpg"	
}

function Get-LSImages {    
	$inboxContent | ForEach-Object {			
		Convert-Images -File $_
	}
}

Get-LSImages
