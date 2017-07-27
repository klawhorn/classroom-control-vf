class users::admins {
  $users = [ 'jose', 'alice', 'chen' ]
  
  users::managed_user { $users: 
    group => 'staff',
  }
  
  group { 'staff':
    ensure => present,
  }

}
