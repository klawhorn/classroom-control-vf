#creates user fundamentals
class users {
  user { 'fundamentals':
    ensure => present,
  }
}
