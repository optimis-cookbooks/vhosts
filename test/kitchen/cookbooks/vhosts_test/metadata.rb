maintainer        'OptimisCorp., Inc.'
maintainer_email  'ops+cookbooks@optimiscorp.com'

license           'Apache 2.0'

description       'Configures apache2 vhosts using node attributes the definition provided by the apache2 cookbook.'

version           '0.0.1'

recipe            'vhosts_test::default', 'Provides setup for the apache2 vhosts cookbook test.'

%w{redhat centos scientific fedora debian ubuntu arch freebsd amazon}.each do |os|
  supports os
end

depends 'vhosts'
