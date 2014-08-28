# FIXME: This class needs better documentation as per https://docs.puppetlabs.com/guides/style_guide.html#puppet-doc
class govuk::node::s_mirrorer inherits govuk::node::s_base {
  include govuk::apps::govuk_crawler_worker
  include govuk_crawler
  include nginx

  # FIXME: Remove once absent
  file { '/usr/local/bin/govuk_update_and_upload_mirror':
    ensure => absent,
    purge  => true,
  }

  # FIXME: Remove once absent
  file { '/usr/local/bin/govuk_update_mirror':
    ensure => absent,
    purge  => true,
  }

  # FIXME: Remove once absent
  file { '/usr/local/bin/govuk_upload_mirror':
    ensure => absent,
    purge  => true,
  }

  # FIXME: Remove once absent
  file { '/var/run/govuk_update_and_upload_mirror.lock':
    ensure => absent,
    purge  => true,
  }

  # FIXME: Remove once absent
  file { '/var/lib/govuk_mirror':
    ensure  => absent,
    force   => true,
    purge   => true,
    recurse => true,
  }

  # FIXME: Remove once absent
  file { '/home/govuk-netstorage':
    ensure  => absent,
    force   => true,
    purge   => true,
    recurse => true,
  }

  # FIXME: Remove once absent
  package { 'govuk_mirrorer':
    ensure   => absent,
    provider => system_gem,
  }

}
