class govuk::apps::datainsight_frontend( $port = 3027 ) {
  govuk::app { 'datainsight-frontend':
    app_type          => 'rack',
    port              => $port,
    health_check_path => '/performance',
    vhost_protected => $::govuk_provider ? {
      /sky|scc/ => false,
      default   => true
    };
  }

  file { ['/mnt/datainsight', '/mnt/datainsight/graphs']:
    ensure => directory,
    owner  => 'deploy'
  }

  file { '/var/tmp/graphs':
    ensure => link,
    target => '/mnt/datainsight/graphs',
  }

  include govuk::phantomjs
  include fonts
}
