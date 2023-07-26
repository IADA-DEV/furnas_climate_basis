Start Project

- redis-server
- bundle exec sidekiq
    - Sidekiq.redis(&:flushdb) # limpa fila do sidekiq
    - DataImportInmetWorker.new.perform('2022-11-02', '2022-11-03', 'A001')





- Schedule
    # Limpa todas as configurações prévias do whenever
    - whenever --clear-crontab
    
    # Para desenvolvimento
    - whenever --update-crontab --set environment='development'

    # atualiza a lista de agendamentos.
    - bundle exec whenever --update-crontab
    
    # verifica a lista
    - crontab -l
    

