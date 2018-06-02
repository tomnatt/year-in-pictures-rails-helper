# Year in pictures helper

Rails app to simplify the monthly process for the [year in pictures site](https://www.theyearinpictures.co.uk/).

See also:

* [Year in pictures](https://github.com/tomnatt/year-in-pictures)
* [Year in pictures React helper](https://github.com/tomnatt/year-in-pictures-helper)

```
bundle exec rake db:create
bundle exec rake db:migrate
YIP_HELPER_EMAIL='foo@example.com' YIP_HELPER_PASSWORD='foobar' YIP_HELPER_NAME='Person' bundle exec rake db:seed
```

The `seed` command will create an admin user with email: 'admin@example.com', password: 'password', fullname: 'admin' unless overridden with the given envars.
