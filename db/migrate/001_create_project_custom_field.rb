class CreateProjectCustomField < ActiveRecord::Migration
  include Redmine::I18n

  def self.up
    caption = ll(:ja, :caption_default_query_custom_field)

    custom_field = ProjectCustomField.new(
      :name => caption, :field_format => "int", :description => "",
      :min_length => "", :max_length => "", :regexp => "",
      :default_value => "", :url_pattern => "",
      :is_required => "0", :visible => "0", :is_filter => "0")

    unless custom_field.save
      puts "Project Custom Filed create failed. name=#{caption}"
      return
    end

    settings = Setting[:plugin_redmine_default_query]
    settings["custom_field_id"] = custom_field.id.to_s
    Setting[:plugin_redmine_default_query] = settings
  end

  def self.down
    # Nothing to do
  end
end
