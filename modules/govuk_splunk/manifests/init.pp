# == Class: govuk_splunk
#
# Install, configure and run Splunk universal forwarder
#
# === Parameters:
#
# [*gds_servers*]
#   string of comma delimited "ipaddress:portnumber" of GDS Splunk cloud servers
#
# [*gds_server_cert*]
#   Private certificate and key of forwarder to contact GDS Splunk cloud
#
# [*gds_root_ca_cert*]
#   certificate of certificate authority of GDS Splunk cloud
#
# [*gds_password*]
#   password to use for GDS Splunk cloud
#
# [*gds_cname*]
#   common name of GDS Splunk cloud
#
# [*cyber_servers*]
#   string of comma delimited "ipaddress:portnumber" of Cyber Splunk cloud
#   servers
#
# [*cyber_server_cert*]
#   certificate of Cyber Splunk cloud
#
# [*cyber_root_ca_cert*]
#   certificate of certificate authority of Cyber Splunk cloud
#
# [*cyber_cname*]
#   common name of Cyber Splunk cloud
#
#
class govuk_splunk(
  $gds_servers,
  $gds_server_cert,
  $gds_root_ca_cert,
  $gds_password,
  $gds_cname,
  $cyber_servers,
  $cyber_server_cert,
  $cyber_root_ca_cert,
  $cyber_cname,
) {

  include govuk_splunk::repos

  package { 'splunk':
    ensure  => latest,
    require => Apt::Source['splunk'],
  }

  package { 'acl':
    ensure  => latest,
  }

  package { 'govuk-splunk-configurator':
    ensure  => latest,
    require => [ Package['splunk', 'acl'],
                Apt::Source['govuk-splunk-configurator'],
                ],
  }

  file {'/opt/splunkforwarder/etc/apps/100_gds_splunkcloud/default/gds_server.pem':
    ensure  => file,
    owner   => 'splunk',
    mode    => '0600',
    content => $gds_server_cert,
    notify  => Service['splunk'],
  }

  file {'/opt/splunkforwarder/etc/apps/100_gds_splunkcloud/default/gds_cacert.pem':
    ensure  => file,
    owner   => 'splunk',
    mode    => '0600',
    content => $gds_root_ca_cert,
    notify  => Service['splunk'],
  }

  file { '/opt/splunkforwarder/etc/apps/100_gds_splunkcloud/default/outputs.conf':
    ensure  => present,
    owner   => 'splunk',
    mode    => '0600',
    content => template('govuk_splunk/opt/splunkforwarder/etc/apps/100_gds_splunkcloud/default/outputs.conf'),
    notify  => Service['splunk'],
  }

  file {'/opt/splunkforwarder/etc/apps/100_hf_connect/default/CyberSplunkUFCombinedCertificate.pem':
    ensure  => file,
    owner   => 'splunk',
    mode    => '0600',
    content => $cyber_server_cert,
    notify  => Service['splunk'],
  }

  file {'/opt/splunkforwarder/etc/apps/100_hf_connect/default/CyberSplunkCACertificate.pem':
    ensure  => file,
    owner   => 'splunk',
    mode    => '0600',
    content => $cyber_root_ca_cert,
    notify  => Service['splunk'],
  }

  file { '/opt/splunkforwarder/etc/apps/100_hf_connect/default/outputs.conf':
    ensure  => present,
    owner   => 'splunk',
    mode    => '0600',
    content => template('govuk_splunk/opt/splunkforwarder/etc/apps/100_hf_connect/default/outputs.conf'),
    notify  => Service['splunk'],
  }

  service { 'splunk':
    ensure  => running,
  }

  @@icinga::check { "check_splunk_running_${::hostname}":
    check_command       => 'check_nrpe!check_proc_running!splunk',
    service_description => 'splunk universal forwarder running',
    host_name           => $::fqdn,
    notes_url           => monitoring_docs_url(check-process-running),
  }

}
