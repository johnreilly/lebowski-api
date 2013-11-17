set :user,          'deploy'
set :branch,        'master'
set :application,   'lebowski-api'
set :deploy_to,     '/var/www/lebowski-api'
set :repo_url,      'git@github.com:aackerman/lebowski-api.git'
set :deploy_via,    :remote_cache
set :ssh_options,   forward_agent: true
set :pty,           true
set :keep_releases, 5
set :linked_files,  %w{config/database.yml}
set :linked_dirs,   %w{log}
role :all,          %w{lebowski.me}
role :app,          %w{lebowski.me}
role :web,          %w{lebowski.me}
role :db,           %w{lebowski.me}

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'
end
