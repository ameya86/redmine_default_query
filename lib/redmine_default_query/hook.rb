class RedmineDefaultQuery::Hook < Redmine::Hook::ViewListener
  render_on :view_projects_form, :partial => 'default_queries/projects_form'
end
