

function New-EC2InstanceSnapshots {
    param (
        [String]$InstanceID
    )

    # Get instance
    $Instance = Get-EC2Instance -InstanceId $InstanceID
    #$Instance.instances | Select *

    # Get all volumes per inctance (array)
    $Volumes = @(get-ec2volume) | ? { $_.Attachments.InstanceId -eq $InstanceID}
    #forEach ($Volume in $Volumes) {
    #    $volume | Select *
    #}
    
    # New snapshot for each volume of the instance
    forEach ($Volume in $Volumes) {
        New-EC2Snapshot -VolumeId $Volume.VolumeId -Description "Automated snapshot - New-EC2InstanceSnapshots"
    }    
}


Import-Module AWSPowerShell

$InstanceId = "i-0afb5a4f3feb27c4a"

New-EC2InstanceSnapshots -InstanceID $InstanceId 
