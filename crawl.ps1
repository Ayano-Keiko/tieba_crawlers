
$json = Get-Content -Encoding utf8 -Path "./kw.json" | ConvertFrom-Json
# $header = @{
#     ""
# }
$kw = $json.name
$numPages = $json.page
# $encodingKW = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::GetEncoding("UTF-8").GetBytes($kw))
# Write-Output $encodingKW

for ($i = 0; $i -lt $numPages; $i ++) {
    $pn = $i * 50
    
    [string]$url = "https://tieba.baidu.com/f?kw=${kw}&ie=utf-8&pn=${pn}"
    # https://tieba.baidu.com/f?kw=%E5%88%80%E5%8A%8D%E7%A5%9E%E5%9F%9F&ie=utf-8&pn=0
    
    $html = Invoke-WebRequest -Method Get -Uri $url -Authentication Basic

    Write-Host $html
    break;
}
# [string]$url = "https://tieba.baidu.com/f?kw=${kw}"

# Write-Output $json.name
# Write-Output $json.page
# Write-Output $url