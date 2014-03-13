# Generic Settings
# the URL or IP address where Polyphemus is running
server_name = server_url = 'gorgus.pyne.io'
# The port to run Polyphemus on
port = 80

# GitHub settings
# a user name with rights to the target repository
github_user = 'pyne-dev'
# the user or organization that owns the repo
github_owner = 'pyne'
# the repo name
github_repo = 'pyne'
# local file to store github login info
github_credentials = '/root/pyne-ci/gh.cred'

# BaTLab settings
# The BaTLab username
batlab_user = 'pyne-ci'
# Location to grab batlab scripts from, may be a zip file or a git repo
batlab_scripts_url = 'https://github.com/pyne/pyne-ci.git'
# the fetch file, will be overwritten with pull request location
batlab_fetch_file = 'fetch/pyne.git'
# top-level run specification
batlab_run_spec = 'pyne.fast.run-spec'
# Optional custom batlab submission command
#batlab_submit_cmd = './submit.sh'
batlab_jobs_cache = '/var/www/gorgus.pyne.io/jobs.cache'

# Apache settings
# Directory for log file, must be writeable and exist.
log_dir = '/root/pyne-ci'
