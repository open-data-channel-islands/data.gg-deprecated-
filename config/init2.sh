#!/bin/sh

# File: /etc/init.d/unicorn

### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the unicorn web server
# Description:       starts unicorn
### END INIT INFO

# Feel free to change any of the following variables for your app:

USER=admin
# Replace [PATH_TO_RAILS_ROOT_FOLDER] with your application's path. I prefer
# /srv/app-name to /var/www. The /srv folder is specified as the server's
# "service data" folder, where services are located. The /var directory,
# however, is dedicated to variable data that changes rapidly, such as logs.
# Reference https://help.ubuntu.com/community/LinuxFilesystemTreeOverview for
# more information.
APP_ROOT="/srv/data/current"
# Set the environment. This can be changed to staging or development for staging
# servers.
RAILS_ENV=production
# This should match the pid setting in $APP_ROOT/config/unicorn.rb.
PID=/srv/data/shared/pids/unicorn.pid
# A simple description for service output.
DESC="Unicorn app - $RAILS_ENV"
# If you're using rbenv, you may need to use the following setup to get things
# working properly:
RBENV_RUBY_VERSION=`cat $APP_ROOT/.ruby-version`
RBENV_ROOT="/home/$USER/.rbenv"
PATH="$RBENV_ROOT/bin:$PATH"
SET_PATH="cd $APP_ROOT && rbenv rehash && rbenv local $RBENV_RUBY_VERSION"
# Unicorn can be run using `bundle exec unicorn` or `bin/unicorn`.
UNICORN="bin/unicorn"
# Execute the unicorn executable as a daemon, with the appropriate configuration
# and in the appropriate environment.
UNICORN_OPTS="-c $APP_ROOT/config/unicorn.rb -E $RAILS_ENV -D"
CMD="$SET_PATH && $UNICORN $UNICORN_OPTS"
# Give your upgrade action a timeout of 60 seconds.
TIMEOUT=60