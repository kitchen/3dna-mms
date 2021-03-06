# == Class: mms
#
# Full description of class mms here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'mms':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Justin Hoppensteadt <hop@nationbuilder.com>
#
# === Copyright
#
# Copyright 2015 3dna
#
class mms {
  include mms::install
  include mms::config
  include mms::service

  # Anchor this as per #8040 - this ensures that classes won't float off and
  # mess everything up.  You can read about this at:
  # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
  anchor { 'mms::begin': }
  anchor { 'mms::end': }

  Anchor['mms::begin'] -> Class['::mms::install'] -> Class['::mms::config']
    ~> Class['::mms::service'] -> Anchor['mms::end']

}
# vim: ft=puppet
