# == Class: Govuk_postgresql::Mirror
#
# Add the apt source for the PostgreSQL aptly mirror
#
class govuk_postgresql::mirror (
  $apt_mirror_hostname,
) {
  if $::lsbdistcodename == 'trusty' {
    apt::source { 'postgresql':
      location     => "http://${apt_mirror_hostname}/postgresql",
      release      => "${::lsbdistcodename}-pgdg",
      architecture => $::architecture,
      key          => '3803E444EB0235822AA36A66EC5FE1A937E3ACBB',
    }
  }
}
