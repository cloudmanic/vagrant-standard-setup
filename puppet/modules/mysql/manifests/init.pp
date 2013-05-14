class mysql 
{
    $mysqlPassword = "foobar"
 
    package 
    { 
        "mysql-server":
            ensure  => present,
            require => Exec['apt-get update']
    }

    service 
    { 
        "mysql":
            enable => true,
            ensure => running,
            require => Package["mysql-server"],
    }

    exec 
    { 
        "set-mysql-password":
            unless => "mysqladmin -uroot -p$mysqlPassword status",
            command => "mysqladmin -uroot password $mysqlPassword",
            require => Service["mysql"],
    }
    
  file { '/usr/local/sbin/mysqlbackup.sh':
  	ensure => present,
    mode => '0700',
    owner => 'root',
    group => 'root',
  	source => "puppet:///modules/mysql/mysqlbackup.sh"
  }
  
  cron { 'mysql-backup':
    ensure  => 'present',
    command => '/usr/local/sbin/mysqlbackup.sh',
    user    => 'root',
    hour    => 23,
    minute  => 5,
    require => File['/usr/local/sbin/mysqlbackup.sh'],
  }

    #exec 
    #{ 
    #    "create-default-db":
    #        unless => "/usr/bin/mysql -uroot -p$mysqlPassword cloudmanic_accounts",
    #        command => "/usr/bin/mysql -uroot -p$mysqlPassword -e 'create database `cloudmanic_accounts`;'",
    #        require => [Service["mysql"], Exec["set-mysql-password"]]
    #}

    #exec 
    #{ 
    #    "grant-default-db":
    #        command => "/usr/bin/mysql -uroot -p$mysqlPassword -e 'grant all on `cloudmanic_accounts`.* to `root@localhost`;'",
    #        require => [Service["mysql"], Exec["create-default-db"]]
    #}
}
