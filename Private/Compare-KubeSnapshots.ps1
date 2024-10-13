function Normalize-Yaml {
    param (
        [hashtable]$YamlObject
    )
    $normalizedObject = @{ }
    foreach ($key in $YamlObject.Keys) {
        if ($key -eq 'status' -or $key -eq 'lastProbeTime' -or $key -eq 'lastTransitionTime') {
            continue
        }
        $value = $YamlObject[$key]
        if ($value -is [hashtable]) {
            $normalizedObject[$key] = Normalize-Yaml -YamlObject $value
        } elseif ($value -is [array]) {
            $normalizedObject[$key] = $value | Sort-Object
        } else {
            $normalizedObject[$key] = Normalize-Value $value
        }
    }
    return $normalizedObject
}

function Normalize-Value {
    param (
        $value
    )
    if ($value -is [string]) {
        return $value.Trim()
    } elseif ($value -is [boolean]) {
        return [string]$value
    } elseif ($value -is [int] -or $value -is [float]) {
        return [string]$value
    } else {
        return $value
    }
}

function Compare-YamlRecursively {
    param (
        [string]$Prefix,
        [hashtable]$Yaml1,
        [hashtable]$Yaml2
    )
    foreach ($key in $Yaml1.Keys) {
        $fullKey = if ($Prefix) { "$Prefix.$key" } else { $key }
        if ($Yaml2.ContainsKey($key)) {
            $value1 = $Yaml1[$key]
            $value2 = $Yaml2[$key]
            if ($value1 -is [hashtable] -and $value2 -is [hashtable]) {
                Compare-YamlRecursively -Prefix $fullKey -Yaml1 $value1 -Yaml2 $value2
            } elseif ($value1 -is [array] -and $value2 -is [array]) {
                Compare-ArraysAsJson -Key $fullKey -Array1 $value1 -Array2 $value2
            } elseif ($value1 -ne $value2) {
                Write-Host "Difference found for key: $fullKey" -ForegroundColor Yellow
                Write-Host "  File1: `n$(ConvertTo-Yaml $value1)" -ForegroundColor Red
                Write-Host "  File2: `n$(ConvertTo-Yaml $value2)" -ForegroundColor Green
            }
        } else {
            Write-Host "Key: $fullKey exists only in File1" -ForegroundColor Yellow
            Write-Host "  File1: `n$(ConvertTo-Yaml $Yaml1[$key])" -ForegroundColor Red
        }
    }
    foreach ($key in $Yaml2.Keys) {
        if (-not $Yaml1.ContainsKey($key)) {
            $fullKey = if ($Prefix) { "$Prefix.$key" } else { $key }
            Write-Host "Key: $fullKey exists only in File2" -ForegroundColor Yellow
            Write-Host "  File2: `n$(ConvertTo-Yaml $Yaml2[$key])" -ForegroundColor Green
        }
    }
}

function Compare-ArraysAsJson {
    param (
        [string]$Key,
        [array]$Array1,
        [array]$Array2
    )
    
    # Normalize the arrays by sorting them
    $sortedArray1 = $Array1 | Sort-Object
    $sortedArray2 = $Array2 | Sort-Object
    
    # Check the length of both arrays first
    if ($sortedArray1.Length -ne $sortedArray2.Length) {
        Write-Host "Difference found for array key: $Key (Array lengths are different)"
        Write-Host "  File1: `n$(ConvertTo-Yaml $sortedArray1)" -ForegroundColor Red
        Write-Host "  File2: `n$(ConvertTo-Yaml $sortedArray2)" -ForegroundColor Green
        return
    }
    
    # Compare each element
    for ($i = 0; $i -lt $sortedArray1.Length; $i++) {
        $element1 = $sortedArray1[$i]
        $element2 = $sortedArray2[$i]
        
        # If elements are hashtables, compare them recursively
        if ($element1 -is [hashtable] -and $element2 -is [hashtable]) {
            Compare-YamlRecursively -Prefix "$Key[$i]" -Yaml1 $element1 -Yaml2 $element2
        } elseif ($element1 -ne $element2) {
            Write-Host "Difference found for array element at index $i under key: $Key"
            Write-Host "  File1: `n$(ConvertTo-Yaml $element1)" -ForegroundColor Red
            Write-Host "  File2: `n$(ConvertTo-Yaml $element2)" -ForegroundColor Green
        }
    }
}

function CompareFiles {
    param (
        [string]$File1,
        [string]$File2
    )
    $yaml1 = Get-Content $File1 -Raw | ConvertFrom-Yaml
    $yaml2 = Get-Content $File2 -Raw | ConvertFrom-Yaml
    $normalizedYaml1 = Normalize-Yaml -YamlObject $yaml1
    $normalizedYaml2 = Normalize-Yaml -YamlObject $yaml2
    Write-Host "Comparing '$File1' and '$File2': `n" -ForegroundColor Green
    Compare-YamlRecursively -Prefix "" -Yaml1 $normalizedYaml1 -Yaml2 $normalizedYaml2
}
