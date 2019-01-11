# == Class: govuk_prometheus_node_exporter
#
# Install and run Prometheus Node Exporter
#
class govuk_prometheus_node_exporter {

  include govuk_prometheus_node_exporter::repo

  package { 'node-exporter':
    ensure  => latest,
    require => Apt::Source['govuk-prometheus-node-exporter'],
  }

  service { 'node-exporter':
    ensure  => running,
  }

  @@icinga::check { "check_prometheus_node_exporter_running_${::hostname}":
    check_command       => 'check_nrpe!check_proc_running!node_exporter',
    service_description => 'prometheus_node_exporter running',
    host_name           => $::fqdn,
    notes_url           => monitoring_docs_url(check-process-running),
  }
}
