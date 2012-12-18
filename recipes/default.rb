raise 'No apache configuration found for node.' unless node['apache2']
raise 'No vhosts configured for this node.' unless node['apache2']['vhosts']

include_recipe 'apache2'

node['apache2']['vhosts'].each do |application|
  web_app application['name'] do
    template 'web_app.ssl.conf.erb'
    server_name application['name']
    server_aliases application['aliases']
    ssl true
    domain application['domain']

    rails_env application['environment']
    variables application['variables'] if application['variables']
  end
end
