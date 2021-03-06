# This class manages:
# V-73625
# The built-in guest account must be renamed.
class secure_windows::stig::v73625 (
  Boolean $enforced = false,
  String $guest_account_name = 'guestaccount',
) {
  if $enforced {
    local_security_policy { 'Accounts: Rename guest account':
      ensure         => 'present',
      policy_setting => 'NewGuestName',
      policy_type    => 'System Access',
      policy_value   => "\"${guest_account_name}\"",
    }
  }
}
