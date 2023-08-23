require 'sidekiq/cron'

# config/initializers/sidekiq.rb
Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
end

if Rails.env.production?
  ('00'..'23').to_a.each do |hour|
    Sidekiq::Cron::Job.create(
      name: "INMET - IMPORT DIARIO - #{hour}:00", # nome do trabalho
      cron: "*/10 #{hour} * * *", # tempo na notação cron, neste caso, a cada 10 minutos dentro da hora
      class: 'DataImportTodayInmetWorker', # nome da classe worker
      args: ["#{hour}00"] # Argumentos para a função perform
    )
  end
end



