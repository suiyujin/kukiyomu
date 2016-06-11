server ENV.fetch('SERVER'), user: ENV.fetch('SSH_USER'), roles: %w(app db web)

role :app, "#{ENV.fetch('SSH_USER')}@#{ENV.fetch('SERVER')}"
role :web, "#{ENV.fetch('SSH_USER')}@#{ENV.fetch('SERVER')}"

set :ssh_options, {
  keys: [ENV.fetch('SSH_KEY')],
  forward_agent: false,
  auth_methods: %w(publickey),
  port: ENV.fetch('SSH_PORT')
}
