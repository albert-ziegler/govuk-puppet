# FIXME: This class needs better documentation as per https://docs.puppetlabs.com/guides/style_guide.html#puppet-doc
class govuk::node::s_prometheus inherits govuk::node::s_base {
  include govuk_prometheus
  include govuk::node::s_app_server
}
