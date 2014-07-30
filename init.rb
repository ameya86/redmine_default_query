require 'redmine_default_query.rb'

Redmine::Plugin.register :redmine_default_query do
  name 'Redmine Default Query plugin'
  author 'OZAWA Yasuhiro'
  description 'Setting default project query.'
  version '0.0.1'
  url 'https://github.com/ameya86/redmine_default_query'
  author_url 'https://github.com/ameya86'

  settings :partial => 'default_queries/settings',
           :default => {
             'custom_field_id' => '',
           }
end
