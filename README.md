Start Project

- redis-server
- bundle exec sidekiq
    - Sidekiq.redis(&:flushdb) # limpa fila do sidekiq