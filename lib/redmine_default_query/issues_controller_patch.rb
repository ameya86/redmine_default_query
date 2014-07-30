require_dependency 'issues_controller'

module RedmineDefaultQuery::IssuesControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods) # obj.method

    base.class_eval do
      before_filter :set_default_query, :only => :index
    end
  end

  module InstanceMethods # obj.method
    QUERY_DEFAULT_FILTERS = {
                              :filters => {
                                "status_id" => {
                                  :operator => "o",
                                  :values => [""]
                                }
                              },
                              :group_by => nil,
                              :column_names => nil
                            }

    def set_default_query
      return if !@project || params[:set_filter] || params[:query_id] ||
                session[:query] && session[:query][:project_id].to_s == @project.id.to_s &&
                QUERY_DEFAULT_FILTERS.merge(:project_id => @project.id) != session[:query]

      custom_field_id = Setting.plugin_redmine_default_query['custom_field_id']

      custom_value = @project.custom_values.where(:custom_field_id => custom_field_id).first
      params[:query_id] = custom_value.to_s
    end
  end
end

IssuesController.send(:include, RedmineDefaultQuery::IssuesControllerPatch)
