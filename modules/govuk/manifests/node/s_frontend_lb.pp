# FIXME: This class needs better documentation as per https://docs.puppetlabs.com/guides/style_guide.html#puppet-doc
class govuk::node::s_frontend_lb (
  $calculators_frontend_servers,
  $draft_frontend_servers,
  $frontend_servers,
  $whitehall_frontend_servers,
){
  include govuk::node::s_base
  include loadbalancer

  Loadbalancer::Balance {
    internal_only => true,
  }

  loadbalancer::balance {
    [
      'draft-collections',
      'draft-email-alert-frontend',
      'draft-frontend',
      'draft-government-frontend',
      'draft-manuals-frontend',
      'draft-service-manual-frontend',
      'draft-smartanswers',
      'draft-static',
    ]:
      servers       => $draft_frontend_servers;
    [
      'canary-frontend',
      'collections',
      'email-alert-frontend',
      'feedback',
      'frontend',
      'government-frontend',
      'info-frontend',
      'manuals-frontend',
      'service-manual',
      'service-manual-frontend',
      'static',
    ]:
      servers       => $frontend_servers;
    [
      'calculators',
      'calendars',
      'finder-frontend',
      'licencefinder',
      'smartanswers',
    ]:
      servers       => $calculators_frontend_servers;
    [
      'whitehall-frontend',
      'draft-whitehall-frontend',
    ]:
      servers       => $whitehall_frontend_servers;
  }
}
