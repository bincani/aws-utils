
# service no longer active
#$FinalIPAddress = ((Invoke-WebRequest ipv4.myip.dk/api/info/IPv4Address).Content).replace('"',"")
function Get-ExternalIP {
    $FinalIPAddress = (Invoke-WebRequest checkip.dyndns.com).Content -replace "[^\d\.]"
    #Write-Verbose "Get-ExternalIP $FinalIPAddress" -Verbose
    return $FinalIPAddress
}

function Grant-SSH-Access([string]$GroupId, [int]$port = 22) {
    $cidrBlocks = New-Object 'collections.generic.list[string]'
    $FinalIPAddress = Get-ExternalIP
    $FinalIPAddress = -join($FinalIPAddress, "/32")
    Write-Output "Grant $FinalIPAddress"
    $cidrBlocks.add($FinalIPAddress)
    $ipPermissions = New-Object Amazon.EC2.Model.IpPermission
    $ipPermissions.IpProtocol = "tcp"
    $ipPermissions.FromPort = $port
    $ipPermissions.ToPort = $port
    $ipPermissions.IpRanges = $cidrBlocks
    Grant-EC2SecurityGroupIngress -GroupId $GroupId -IpPermissions $ipPermissions
}

