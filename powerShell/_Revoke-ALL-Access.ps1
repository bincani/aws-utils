# https://github.com/CarmenAPuccio/AWSSecurityGroupAudit/blob/master/SecurityGroupAudit.ps1

function Revoke-ALL-Access([string]$GroupId) {
    $EC2SecGrpToDel = Get-EC2SecurityGroup -GroupId $GroupId
    foreach ($nest in $EC2SecGrpToDel.IpPermissions) {
        $nestedGrp = $nest | Where-Object ({$_.UserIdGroupPairs.GroupId -in $securityGroupsNested -or $_.UserIdGroupPairs.GroupId -in $securityGroupsOrphaned})
        foreach ($grp in $nestedGrp) {
            Revoke-EC2SecurityGroupIngress -GroupId $EC2SecGrpToDel.GroupId -IpPermission $grp
            $IpPerms = "$($grp.IpRange):$($grp.FromPort)"
            echo "delete $IpPerms from $($EC2SecGrpToDel.GroupId)"
        }                
    }
}