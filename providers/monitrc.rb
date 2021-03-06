action :create do

  tpl_file = new_resource.template.nil? ? new_resource.name : new_resource.template

  template "#{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc" do
    owner "root"
    group "root"
    mode  "0644"
    source "#{tpl_file}.monitrc.erb"
    variables new_resource.variables
    notifies :restart, "service[monit]", :immediately
    action :create
  end

  # My state has changed so I'd better notify observers
  new_resource.updated_by_last_action(true)
end

action :delete do
  execute "delete monitrc" do
    command "rm -f #{node["monit"]["includes_dir"]}/#{new_resource.name}.monitrc"
  end

  new_resource.updated_by_last_action(true)
end