# == Class: govuk_jenkins::jobs::transition_load_site_config_redirect
#
# Create a file on disk that can be parsed by jenkins-job-builder
#
class govuk_jenkins::jobs::transition_load_site_config_redirect {
  file { '/etc/jenkins_jobs/jobs/transition_load_site_config.yaml':
    ensure  => present,
    content => template('govuk_jenkins/jobs/transition_load_site_config_redirect.yaml.erb'),
    notify  => Exec['jenkins_jobs_update'],
  }
}
