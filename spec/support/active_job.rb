require 'sidekiq/testing'

Rails.application.config.active_job.queue_adapter = :sidekiq

Sidekiq::Testing.inline!
