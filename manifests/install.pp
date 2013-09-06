# == Class: docker
#
# Module to install an up-to-date version of Docker from the
# official Apt repository. The use of this repository means, this module works
# only on Debian based distributions.
#
# === Parameters
# [*version*]
#   The package version to install, passed to ensure.
#   Defaults to present.
#
class docker::install {
  include apt
  validate_string($docker::version)
  validate_re($::osfamily, '^Debian$', 'This module uses the docker apt repo and only works on Debian systems that support it.')

  apt::source { 'docker':
    location          => 'https://get.docker.io/ubuntu',
    release           => 'docker',
    repos             => 'main',
    key               => 'A88D21E9',
    key_source        => 'http://get.docker.io/gpg',
    pin               => '10',
    include_src       => false,
  }

  package { 'lxc-docker':
    ensure  => $docker::version,
    require => Apt::Source['docker'],
  }

}
