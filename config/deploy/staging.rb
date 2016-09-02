server 'ec2-54-196-181-31.compute-1.amazonaws.com', user: 'ec2-user', roles: %w(app db web)
set :ssh_options,
    keys: %w(/var/lib/jenkins/.ssh/dhsflash.pem),
    forward_agent: true
