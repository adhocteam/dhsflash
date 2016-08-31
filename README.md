# dhsflash
Ad Hoc's submission to the DHS FLASH Technical Challenge Exercise

## Install and launch mailcatcher
In development, the app sends emails to mailcatcher. You'll need it running in order to get the emails required to create your account.
```
gem install mailcatcher
mailcatcher -b
```

## Create the database
```
rake db:create
```

## Start up the app
```
rails s
```

## Create a user account and confirm it
Open up the [app locally](http://localhost:3000) and click Sign Up to create an account. That will cause a confirmation email to
show up in mailcatcher. Click the confirmation link there and you'll be good to go.

## Make yourself an admin
You'll need to make the first user an admin manually. After that you can manage admins in the UI.
```
rails c
User.first.add_role(:admin)
```
