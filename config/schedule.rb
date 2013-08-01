# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 5.minutes do
  runner "Cronfeed.updatefeedswithcron"
  runner "Cronfeed.updatefeedswithlanguage"
end

every 2.minutes do
  runner "Cronfeed.updatefeedswithlocation"
end

#
# every 4.days do
    #   command "/usr/bin/some_great_command"
#   runner "AnotherModel.prune_old_records"
#   rake "some:great:rake:task"
# end

# Learn more: http://github.com/javan/whenever
