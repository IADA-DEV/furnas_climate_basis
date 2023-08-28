Start Project

- redis-server
- bundle exec sidekiq
    - Sidekiq.redis(&:flushdb) # limpa fila do sidekiq
    - DataImportInmetWorker.new.perform('2023-08-27', '2023-08-27', 'A002')
    - DataImportTodayInmetWorker.new.perform('2200')

id_station = 'A001'
date = '2023-08-27'
import = DataImportInmet.create(dta_inicio: date, dta_fim: date, inmet_weather_station_id: id_station, status: false)

DataImportInmetWorker.perform_async(date, date, id_station, import.id)


- Schedule
    # Limpa todas as configurações prévias do whenever
    - whenever --clear-crontab
    
    # Para desenvolvimento
    - whenever --update-crontab --set environment='development'

    # atualiza a lista de agendamentos.
    - bundle exec whenever --update-crontab
    
    # verifica a lista
    - crontab -l
    

