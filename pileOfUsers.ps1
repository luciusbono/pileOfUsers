param($inputfile = [Environment]::GetFolderPath("Desktop")+'\'+'users.csv', $outputBad = [Environment]::GetFolderPath("Desktop")+'\'+'outputBad.csv', 
$outputGood = [Environment]::GetFolderPath("Desktop")+'\'+'outputGood.csv')

$input = Import-CSV $inputfile

New-Item $outputBad -type file -force

Write-Host `n `n "Exporting users to: " `n $outputBad `n $outputGood

$(foreach($_.samaccountname in $input)
{
	$chkusr = Get-QADUser -name $_.samaccountname
	if($chkusr)
	{
		$chkusr | select displayname,email
	}
	else
		{
			Add-Content $outputBad $_.samaccountname
		}
}) | Export-Csv $outputGood -NoTypeInformation

Write-Host `n `n "Done!"