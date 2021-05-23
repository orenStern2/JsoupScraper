[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/json")

$body = "{`n    `"payload`": {`n        `"summary`": `"Testing from PowerShell`",`n        `"severity`": `"critical`",`n        `"component`": `"xyz`",`n        `"source`": `"PowerShell`",`n        `"group`": `"test`",`n        `"class`": `"alert`",`n        `"custom_details`": {`n            `"field1`": `"value1`"`n        }`n    },`n    `"routing_key`": `"R029PPL030SPPECQN32BD3A3N1WNMB42`",`n    `"dedup_key`": `"`",`n    `"event_action`": `"trigger`"`n}"

$response = Invoke-RestMethod 'https://events.pagerduty.com/v2/enqueue' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

