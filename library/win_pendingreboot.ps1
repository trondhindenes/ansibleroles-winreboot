#!powershell
# (c) 2015, Trond Hindenes <trond@hindenes.com>, and others
#
# This file is part of Ansible
#
# Ansible is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ansible is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ansible.  If not, see <http://www.gnu.org/licenses/>.

# WANT_JSON
# POWERSHELL_COMMON

$params = Parse-Args $args;
$result = New-Object psobject;
Set-Attr $result "changed" $false;
Set-Attr -obj $result -name "pending_reboot" -value $false

$rebootpolicy = Get-Attr -obj $params -name "reboot_behavior" -default "never"
if (!("never","if_required","always" -contains $rebootpolicy))
{
    Fail-Json -obj $result -message "reboot_behavior must be one of: never,if_required,always"
}

$simulate = Get-Attr -obj $params -name "simulate" -default "false"
$simulate = $simulate | ConvertTo-Bool

if ($simulate -eq $true)
{
    
}


# Check if reboot is required, if so notify CA. The MSFT_ServerManagerTasks provider is missing on client SKUs
$featureData = invoke-wmimethod -EA Ignore -Name GetServerFeature -namespace root\microsoft\windows\servermanager -Class MSFT_ServerManagerTasks
$regData = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" "PendingFileRenameOperations" -EA Ignore
if(($featureData -and $featureData.RequiresReboot) -or $regData)
{
    Set-Attr -obj $result -name "pending_reboot" -value $true   
}

if ($simulate -eq $true)
{
    Set-Attr -obj $result -name "pending_reboot" -value $true   
}

$Doreboot = $false
if ($rebootpolicy -eq "always")
{
    $Doreboot = $true
}

if (($rebootpolicy -eq "if_required") -and ($result.pending_reboot -eq $true))
{
    $Doreboot = $true
}






if ($Doreboot -eq $true)
{
    Restart-Computer -Force -AsJob
}
Exit-Json -obj $result
    