name 'vhosts'

maintainer        'OptimisCorp., Inc.'
maintainer_email  'ops+cookbooks@optimiscorp.com'

license           'Apache 2.0'

description       'Configures apache2 vhosts using node attributes the definition provided by the apache2 cookbook.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version           '0.0.1'

recipe            'vhosts::default', 'Configures apache2 vhosts.'

%w{redhat centos scientific fedora debian ubuntu arch freebsd amazon}.each do |os|
  supports os
end

depends 'apache2'

attribute 'apache2/vhosts/name',
  :display_name => 'Apache ServerName Directive',
  :description => 'The apache server name directive.',
  :type => 'string'

attribute 'apache2/vhosts/aliases',
  :display_name => 'Apache ServerAlias Directive',
  :description => 'The server aliases directive.',
  :type => 'array'

attribute 'apache2/vhosts/ssl',
  :display_name => 'Apache SSL Configuration',
  :description => 'A boolean setting that determines if a SSL vhost should be set.'

attribute 'apache2/vhosts/domain',
  :display_name => 'SSL Domain',
  :description => 'The SSL domain configuration.',
  :type => 'string'

attribute 'apache2/vhosts/environment',
  :display_name => 'Passenger RailsEnv Directive',
  :description => 'Sets the rails environment.',
  :type => 'string'
