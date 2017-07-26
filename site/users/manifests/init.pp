#creates user fundamentals
class users {
  user { 'fundamentals':
    ensure           => 'present',
    home             => '/home/fundamentals',
    password_max_age => '99999',
    password_min_age => '0',
    shell            => '/bin/bash',
  }
}
