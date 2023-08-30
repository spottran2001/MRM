set :application, "MRM"
#set :repo_url, "https://github.com/spottran2001/MRM.git"
set :repo_url, 'https://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@github.com/spottran2001/MRM'

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# Only keep the last 5 releases to save disk space
set :keep_releases, 5
