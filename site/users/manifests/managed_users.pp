define users::managed_user (
  $group = $title,
){
  user { $title:
    ensure => present,
  }
}
