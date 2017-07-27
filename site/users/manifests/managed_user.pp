define users::managed_user (
  $group = $title,
){
  user { $title:
    ensure => present,
  }

  $home = $facts['os']['family'] ? {
    'windows' => 'C:/Users',
    default   =>  '/home',
  }

  file "${home}/${title}":
    ensure  =>  directory,
    owner =>  $title,
    group =>  $title,
  } 

  file "${home}/${title}/.ssh":
    ensure  =>  directory,
    owner =>  $title,
    group =>  $title,
    mode  =>  '0700',
  } 
}
