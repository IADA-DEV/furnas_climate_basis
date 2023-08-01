require 'sidekiq/cron'

# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

('00'..'23').to_a.each do |hour|
  Sidekiq::Cron::Job.create(
    name: "INMET - IMPORT DIARIO - #{hour}", # nome do trabalho
    cron: "0 #{hour} * * *", # tempo em cron notation, neste caso, a cada hora
    class: 'DataImportTodayInmetWorker', # nome da classe worker
    args: "'#{hour}00'" # Argumentos para a função perform
  )
end

# Sidekiq::Cron::Job.create(
#   name: "Nome do Job - 21:10", # nome do trabalho
#   cron: "10 21 * * *", # tempo em cron notation, neste caso, todos os dias às 21:10
#   class: 'DataImportTodayInmetWorker', # nome da classe worker
#   args: "'2100'" # Argumentos para a função perform
# )
