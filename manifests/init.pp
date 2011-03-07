# Class: fusioninventory
#
# This module manages fusioninventory
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class fusioninventory {

     yumrepo {
        "remi":
            descr => "Les RPM de remi pour Enterprise Linux 5",
            baseurl => "http://rpms.famillecollet.com/enterprise/5/remi/$hardwaremodel",
            enabled => 1,
            gpgcheck => 0,
    }

    package {
        "fusioninventory-agent":
            ensure => installed,
            require => Yumrepo["remi"],
    }

    package {
        "perl-FusionInventory-Agent-Task-SNMPQuery":
            ensure => installed,
            require => Package["fusioninventory-agent"],
    }

    package {
        "perl-FusionInventory-Agent-Task-NetDiscovery":
            ensure => installed,
            require => Package["fusioninventory-agent"],
    }

    file {
        "/etc/fusioninventory/agent.cfg":
            ensure  => present,
            mode    => 0444,
            owner   => "root",
            group   => "root",
            source  => "puppet:///modules/fusion/agent.cfg",
            require => Package["fusioninventory-agent"];
    }

    file {
        "/etc/sysconfig/fusioninventory-agent":
            ensure  => present,
            mode    => 0444,
            owner   => "root",
            group   => "root",
            source  => "puppet:///modules/fusion/fusioninventory-agent",
            require => Package["fusioninventory-agent"];
    }
}

}
