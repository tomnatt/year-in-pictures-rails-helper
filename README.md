# Year in pictures helper

Rails app to simplify the monthly process for the [year in pictures site](https://www.theyearinpictures.co.uk/).

See also:

* [Year in pictures](https://github.com/tomnatt/year-in-pictures)
* [Year in pictures React helper](https://github.com/tomnatt/year-in-pictures-helper)

```
bundle exec rake db:create
bundle exec rake db:migrate
YIP_HELPER_EMAIL='foo@example.com' YIP_HELPER_PASSWORD='foobar' bundle exec rake db:seed
```

The `seed` command will create an admin user with email: 'admin@example.com', password: 'password' unless overridden with the envars `YIP_HELPER_EMAIL` and `YIP_HELPER_PASSWORD`.

## TODO:

### Deployment
* ~~Deploy to Heroku~~
* ~~S3 bucket~~
** Connect to upload in app
** Lambda function to resize images

### Authentication
* Sign-up
* Hide destructive options
* Lock pictures to people

### Homepage
* ~~Add count~~
* ~~Sort photographs~~
* Add name of active user
* Improve CTA

### Input:
* Hide automatic fields
* WYSIWYG helpers
