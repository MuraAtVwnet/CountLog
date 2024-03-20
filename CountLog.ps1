$HerTergetDirs = @"
D:\IIS_Logs\W3SVC2\2023\2023-01
D:\IIS_Logs\W3SVC2\2023\2023-02
D:\IIS_Logs\W3SVC2\2023\2023-03
D:\IIS_Logs\W3SVC2\2023\2023-04
D:\IIS_Logs\W3SVC2\2023\2023-05
D:\IIS_Logs\W3SVC2\2023\2023-06
D:\IIS_Logs\W3SVC2\2023\2023-07
D:\IIS_Logs\W3SVC2\2023\2023-08
D:\IIS_Logs\W3SVC2\2023\2023-09
D:\IIS_Logs\W3SVC2\2023\2023-10
D:\IIS_Logs\W3SVC2\2023\2023-11
D:\IIS_Logs\W3SVC2\2023\2023-12
D:\IIS_Logs\W3SVC2\2024-01
D:\IIS_Logs\W3SVC2\2024-02
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
