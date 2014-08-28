Description
===========

This cookbook allows configuration of apache2 vhosts using attributes and the definition provided by the apache2 cookbook.

The attributes can be set at any of the following levels:

* global attributes
* environment attributes
* role attributes
* node attributes
* cookbook attributes

This cookbook ships with templates for non SSL and SSL based configurations. 

Requirements
============

## Cookbooks:

This cookbook depends on the following cookbooks:

* apache2

## Platforms:

* Debian
* Ubuntu
* Red Hat/CentOS/Scientific Linux/Fedora (RHEL Family)
* SUSE/OpenSUSE
* ArchLinux
* Amazon Linux AMI

Attributes
==========

This cookbook uses the following attributes: 

* `node['apache']['vhosts']['name']` - This sets the value of the ServerName directive.
* `node['apache']['vhosts']['aliases']` - This sets the value of the ServerAlias directive (One for each alias provided).
* `node['apache']['vhosts']['ssl']` - This boolean determines if an SSL vhost is created.
* `node['apache']['vhosts']['domain']` - This sets the value of the domain used for SSL certificates.
* `node['apache']['vhosts']['environment']` - This sets the passenger directive for RailsEnv.

Recipes
=======

default
-------

The default recipe writes the vhost templates based on node attributes and enables them.

### Apache2 Cookbook Parameters:

The apache2 cookbook parameters used by the definition are:

* `name` - The name of the site. The install directory will also match the name.
* `cookbook` - The custom source templates are used for SSL vhost configuration.
* `template` - `web_app.conf.erb`, source template file. 
* `enable` - true.

Usage
=====

Using this cookbook is relatively straightforward. Add the desired attributes to a node, role or in a cookbook.

    % cat roles/rails.rb

    name 'rails'
    description 'The rails application server role.'

    run_list 'recipe[apache2]', 'recipe[apache2::mod_ssl]', 'recipe[vhosts]'

    override_attributes(
      'apache2' => {
        'vhosts' => {
          'name' => 'rails.company.com',
          'aliases' => [ 'content-test.optimispt.com' ],
          'domain' => 'company',
          'environment' => 'production'
        }
      }
    )

License and Authors
===================

Author:: Umang Chouhan <uchouhan@optimisdev.com>

Copyright:: 2012-2013, OptimisCorp., Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
