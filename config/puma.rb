threads_count = Integer(ENV.fetch('RAILS_MAX_THREADS', 5))
threads threads_count, threads_count

port ENV.fetch('PORT', 3000)
environment ENV.fetch('RAILS_ENV', 'development')

pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

workers Integer(ENV.fetch('WEB_CONCURRENCY', 2))

preload_app!

plugin :tmp_restart
