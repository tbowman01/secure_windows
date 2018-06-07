# This fact returns the ftp root of a FTP Server with a site equal to fqdn
require 'facter'
Facter.add('winver') do
  confine operatingsystem: :windows
  out = new Hash
  setcode do
    powershell = 'C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe'
    command = "[environment]::OSVersion.Version | select Major, Minor, Build | FT -HideTableHeaders -AutoSize"
    out = Facter::Core::Execution.execute("#{powershell} -command \"#{command}\"")
  end
end