define users::managed_users {
  $group= $title, 
}{
user {$title:
  ensure => present,
  }
  $home = $facts{'os'}{'family'}?{
    'windows' => 'c:users',
    default => '/home',
file {"${home}/$title}":
  ensure => directory,
  owner => $title,
  
}
}
