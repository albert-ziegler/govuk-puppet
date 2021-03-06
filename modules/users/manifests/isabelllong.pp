# Creates the isabelllong user
class users::isabelllong {
  govuk_user { 'isabelllong':
    ensure   => absent,
    fullname => 'Isabell Long',
    email    => 'isabell.long@digital.cabinet-office.gov.uk',
    ssh_key  => [
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7HfCT0IusPqKxxEbap5yK1xBrKUpSB8B8wdiK5LgSWbaf78oY25nK5LE6i+NTFVt1Kxpd5uYs7/X3BquvdDrnkRVeJyfqDpJFSSSQBHiHSoVLv+EYzEYVRac7BT/riWSsNrGRGhAMMo84rWmSFmQxDBgJ4XMhv4Z0/2eBNRK+uZv+PHiOrWu8uAGmyr5s8bj93UqzafaoUaCcUBoWMGGk0pkmThlRAThpduvOvYqlX4YIbJ3vgEUfxCWhedmgbo2n4UXq8YISE46b5m9YmH31ZDifZ+WF3QXHsGQZmsB5TgSjTLHQGqoI7XpfTd1T1dGnIFT8ykBVrOFa7N5/AVn3AKBT3F63Ct9rMqdx9oIAn7d8OJQrFQfA1j+8fnUysEsO7lNALA/M0rAwAPwwC+YGwaspwTEzjFFK5/jPFhk+Z8n9PHZflxPN6bhRwv7PhK6tCmJ3jEogBSljE+/aLMS32HaaBjtxQO4AcjdxAB0ICsoY+Jl3kldJPudttrG6APufr0pSemNRPz6sVoxsph85CxdImKt+EDLpOxq25D+gQv2ACHRuDsqrZO2xDt357nqEoJNEL9W6BBDyeC2AIWA+59v4z7NveZf58Y8YhBZ5ZJdHOUP545V9tDBQDuttWYR/JoU4iPegKPuYZuayPYyYIcqSF2HIbbQ31qvyLSTs2w== isabell.long@digital.cabinet-office.gov.uk',
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/oJXjiJWsS9mauyNO7bxqWKaJHiwuXuOjui8yk/Gc6mMRt1yhjrRNEK2XdlU7vunolzsiNWB6AY1gJlsXVLBwd0+oqOXRAeL0uAL2y9W8JB5kMdz2Davj9tYt1pSL9MB6fTj4hmc2RuY7MM8dGL6q4J+c4LCn+8OIoakqVF5tb0PMoT8mItRu5/0I1MGOLn73b8isIONmf4pXCtfPlRuB0HsUwEBmoFaCBvvtmBq26431nn9P2THcAl6iEWvK/u61x8wWTFcKIzdQI3KDmp5gM6YHi78EvDe41X16fnVcfs7B+gxCLxmoWuOYJHoWwikETDtg1ZVl2V+e1UWgTT36/7fIRTxWlaiFvtjkmxgaLM5WHGXpEUOGdVu5QVr+jTjpkancyIhyFv/h/iOJ7p9InTan42NxrKLTxnBgCds5OgEEpsnKhGNON5OBNbI6e/Lw/J62jx4lR0ShXWHAhkn13UkT1002FJMNPIYuKV4UvEZfmS4hyPO44zgtManU5gsqGGhPr64GNC/ahXaBBXeNUHtzpveRc73KN4CU3sPXmoN8amrhAJ0CZ9wXj9TklkKWqyDRiztxYYiJrerc9v2RUgya0NNDIsVzyD7qnMznApIV66WImcBmGfZuxSg9SVE8tcFPaWiQS5rsjE01IHtr5fhY3oLQmD3lQC2FsjQOhQ== isabelllong@gds-dev-home',
    ],
  }
}
