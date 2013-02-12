actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :template, :kind_of => String
attribute :variables, :kind_of => Hash
