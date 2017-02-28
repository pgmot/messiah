# sidekiq

```
bundle exec sidekiq -r ./config/boot.rb -C config/sidekiq.yml -d
```

```
bundle exec padrino rake ar:create ar:migrate
bundle exec padrino rake ar:migrate
```

```
mkdir -p tmp/pids tmp/sockets log
bundle exec unicorn -c config/unicorn.rb -E production -D
kill -9 `cat tmp/pids/unicorn.pid`
```
