class rabbitinstall inherits common {

  $rabbit_config = hiera_hash('rabbitinstall::conf')

  include repositories::erlangsolutions
  include repositories::rabbitdlbintraycom

  package { ['rabbitmq-server']:
    ensure => present,
    ensure => latest
  }~>

  file { '/etc/rabbitmq':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }~>

  file { '/etc/rabbitmq/ssl':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }~>

  file { 'rabbitmq.config':
    ensure  => file,
    path    => '/etc/rabbitmq',
    content => template('rabbitinstall/rabbitmq.config.erb'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
#    notify  => Class['rabbitmq::service'],
  }~>

  file { 'rabbitmq-env.conf':
    ensure  => file,
    path    => '/etc/rabbitmq',
    content => template('rabbitinstall/rabbitmq-env.conf.erb'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }~>

  file { 'rabbitmqadmin.conf':
    ensure  => file,
    path    => '/etc/rabbitmq',
    content => template('rabbitinstall/rabbitmqadmin.conf.erb'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
  }~>

  service { 'rabbitmq-server':
    ensure => running,
    enable => true
  }~>

}
