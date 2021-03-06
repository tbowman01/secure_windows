# This class manages V-26485
# (Domain Controllers)
# The Deny log on locally user right on domain controllers must be configured to prevent unauthenticated access.
# (Member Servers)
# The Deny log on locally user right on member servers must be configured to prevent access from highly privileged
# domain accounts on domain systems, and from unauthenticated access on all systems.

class secure_windows::stig::v26485 (
  Boolean $enforced = true,
) {
  if $enforced {
    if($facts['windows_server_type'] == 'windowsdc') {
      #domain controller
      local_security_policy { 'Deny log on locally':
        ensure         => 'present',
        policy_setting => 'SeDenyInteractiveLogonRight',
        policy_type    => 'Privilege Rights',
        policy_value   => '*S-1-5-32-546',
      }
    }
    elsif !($facts['windows_server_type'] == 'windowsdc') {
      if($facts['windows_type'] =~ /(0|2)/) {
        #standalone
        local_security_policy { 'Deny log on locally':
          ensure         => 'present',
          policy_setting => 'SeDenyInteractiveLogonRight',
          policy_type    => 'Privilege Rights',
          policy_value   => '*S-1-5-32-546',
        }
      }
      elsif ($facts['windows_type'] =~ /(1|3)/) {
        #member server
        #NOTE: Systems dedicated to the management of Active Directory are exempt from this :(
        local_security_policy { 'Deny log on locally':
          ensure         => 'present',
          policy_setting => 'SeDenyInteractiveLogonRight',
          policy_type    => 'Privilege Rights',
          policy_value   => 'Domain Admins,Enterprise Admins,*S-1-5-32-546',
        }
      }
    }
  }
}
