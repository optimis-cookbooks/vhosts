raise 'No apache configuration found for node.' unless node['apache2']
raise 'No vhosts configured for this node.' unless node['apache2']['vhosts']

include_recipe 'apache2'

node['apache2']['vhosts'].each do |vhost|
  web_app vhost['name'] do
    template 'web_app.ssl.conf.erb'
    server_name vhost.fetch('name')
    server_aliases vhost.fetch('aliases')
    ssl true
    domain vhost.fetch('domain')

    rails_env vhost.fetch('environment')
  end
end
