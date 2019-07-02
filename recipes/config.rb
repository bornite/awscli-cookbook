node[:awscli][:config_profiles].each do |user, config_profiles|
  next unless node[:etc][:passwd].key?(user)
  config_file = "#{node[:etc][:passwd][user][:dir]}/.aws/config"

  directory(::File.dirname(config_file)) do
    action :create
    recursive true
    owner user
    group user
    mode 00700
    not_if { ::File.exist?(::File.dirname(config_file)) }
  end

  template(config_file) do
    mode 00600
    owner user
    group user
    source 'config.erb'
    variables(
      config_profiles: config_profiles,
    )
  end
end

node[:awscli][:credentials].each do |user, credentials|
  next unless node[:etc][:passwd].key?(user)
  config_file = "#{node[:etc][:passwd][user][:dir]}/.aws/credentials"

  directory(::File.dirname(config_file)) do
    action :create
    recursive true
    owner user
    group user
    mode 00700
    not_if { ::File.exist?(::File.dirname(config_file)) }
  end

  template(config_file) do
    source 'credential.erb'
    mode 00600
    owner user
    group user
    variables(
      credentials: credentials,
    )
  end
end
