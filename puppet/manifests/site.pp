node 'development.puppetlabs.vm' {
    class { 'nodejs':
        version => 'v0.10.25',
    }

    exec { "apt-update":
        command => "/usr/bin/apt-get update"
    }

    Exec["apt-update"] -> Package <| |>

    package { 'coffeescript':
        ensure => latest,
    }

    package { 'forever':
        provider => 'npm',
    }

    class { 'redis':
        version => '2.6.5',
    }
}