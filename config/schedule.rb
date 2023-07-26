# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# execut que da certo na mão no terminal
# /bin/bash -l -c 'cd /Users/nortonricardo/Desktop/furnas_climate_basis && ~/.rbenv/shims/bundle exec bin/rails runner -e development '\''DataImportTodayInmetWorker.perform_async()'\'' >> ./log/cron_log.log 2>&1'

# Example:
# every 1.minute do 
#     runner "DataImportTodayInmetWorker.perform_async()"
# end


# configs
env :PATH, ENV['PATH']
set :output, "./log/cron_log.log"
job_type :runner,  "cd :path && ~/.rbenv/shims/bundle exec rails runner -e :environment ':task' :output"



# agenda jobs de import de hora em hora 
('00'..'23').to_a.each do |hour|
  every :day, :at => "#{hour}:00" do
    runner "DataImportTodayInmetWorker.perform_async('#{hour}00')"
  end
end


# every :hour do 
#     runner "DataImportTodayInmetWorker.perform_async(Time.now.strftime('%H%M'))"
# end
