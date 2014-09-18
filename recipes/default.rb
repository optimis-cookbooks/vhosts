raise 'No apache configuration found for node.' unless node['apache2']
raise 'No vhosts configured for this node.' unless node['apache2']['vhosts']

include_recipe 'apache2'

if node['apache2']['vhosts'].is_a? Hash
  vhosts = node['apache2']['vhosts'].collect do |title, vhost|
    vhost.merge title: title
  end
else
  vhosts = node['apache2']['vhosts']
end

vhosts.each do |vhost|
  web_app vhost['name'] do
    template 'web_app.ssl.conf.erb'
    server_name vhost['name']
    server_aliases vhost['aliases']
    ssl (vhost['ssl'] or true)
    domain vhost['domain']
    rails_env vhost['environment']
    passenger_ruby vhost['passenger_ruby']
    locations vhost['locations']

    if vhost['path']
      path vhost['path']
    else
      path "/var/www/#{vhost['name']}/current/public"
    end
  end
end
