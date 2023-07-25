Start Project

- redis-server
- bundle exec sidekiq
    - Sidekiq.redis(&:flushdb) # limpa fila do sidekiq
    - DataImportInmetWorker.new.perform('2022-11-02', '2022-11-03', 'A001')
