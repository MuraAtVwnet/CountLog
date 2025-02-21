$HerTergetDirs = @"
D:\IIS_Logs\W3SVC2\2024\2024-01
D:\IIS_Logs\W3SVC2\2024\2024-02
D:\IIS_Logs\W3SVC2\2024\2024-03
D:\IIS_Logs\W3SVC2\2024\2024-04
D:\IIS_Logs\W3SVC2\2024\2024-05
D:\IIS_Logs\W3SVC2\2024\2024-06
D:\IIS_Logs\W3SVC2\2024\2024-07
D:\IIS_Logs\W3SVC2\2024\2024-08
D:\IIS_Logs\W3SVC2\2024\2024-09
D:\IIS_Logs\W3SVC2\2024\2024-10
D:\IIS_Logs\W3SVC2\2024\2024-11
D:\IIS_Logs\W3SVC2\2024\2024-12
D:\IIS_Logs\W3SVC2\2025-01
"@


####################################
# ヒア文字列を配列にする
####################################
function HereString2StringArray( $HereString ){
    $Temp = $HereString.Replace("`r","")
    $StringArray = $Temp.Split("`n")
    return $StringArray
}

$TergetDirs =  HereString2StringArray $HerTergetDirs

[long]$Lines = 0

foreach($TergetDir in $TergetDirs){
	echo $TergetDir
	$TergetPattan = Join-Path $TergetDir "*.log"
	$TergetFiles = Get-ChildItem $TergetPattan -Recurse
	foreach( $TergetFile in $TergetFiles){
		$TergetFileFullName = $TergetFile.FullName
		echo $TergetFileFullName
		$Logs = Get-Content $TergetFileFullName
		foreach($Log in $Logs){
			if( ($Log -Match "htm") -or ($Log -Match "html")){
				$Lines++
			}
		}
	}
}

echo $Lines
