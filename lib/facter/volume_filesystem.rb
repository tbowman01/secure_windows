#
# This fact returns local volumes that are not NTFS or ReFS
#
Facter.add('volume_filesystem') do
  confine operatingsystem: :windows
  setcode do
    powershell = 'C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe'
    command = 'Get-Volume | Select FileSystem | FT -HideTableHeaders'
    $filesystems = Facter::Core::Execution.exec(%(#{powershell} -command "#{command}"))
    $filesystems2 = $filesystems.split("\r\n")
    $filesystems2.each do |filesystem|
      if filesystem.match(/(NTFS|ReFS)/)
      else
        return false
      end
    end
    return true
  end
end