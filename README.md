# "Kudos!" for DHS Flash

Ad Hoc's submission to the DHS FLASH Technical Challenge Exercise.

## Getting started

### Install and launch mailcatcher

In development, the app sends emails to mailcatcher. You'll need it running in
order to get the emails required to create your account. It's not part of the
app per se so we install it outside the Gemfile.

```
gem install mailcatcher
mailcatcher -b
```

### Install Gems dependencies

```
bundle install
```

### Create and migrate the database

```
rake db:create
rake db:migrate
```

### Start up the app

```
rails s
```

### Create a user account and confirm it

Open up the [app locally](http://localhost:3000) and click Sign Up to create an
account. That will cause a confirmation email to show up in mailcatcher. Click
the confirmation link there and you'll be good to go.

### Make yourself an admin

You'll need to make the first user an admin manually. After that you can manage
admins in the UI.

```
rails c
User.first.add_role(:admin)
```

test!
another!
another!