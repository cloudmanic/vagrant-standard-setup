class mysql 
{
    $mysqlPassword = "yLzyv*4o}+I~qY}/t;J;>Hv"
 
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