# gds-infoshare
A simple tool to share information within Common Technology Services within GDS.

## Schema

Department
- name
- nickname
- engagement manager?
- Has many: contracts
- has_many: initiatives

Contract
- value
- dates
- has_many: products
- belongs_to: department
- belongs_to: supplier

Engagement
- phase
- name
- dates
- description
- has_many: deployments
- belongs_to: department
- has_many: benefits

Benefit
- name
- value_cents
- notes
- cashable (boolean)
- has_many: contracts

Deployment
- cost
- progress (0-1)
- has_many: updates
- has_many: products
- belongs_to: engagement

update
- date
- headline
- owner
- detail
- progress? (float 0-1)
- RAG status? (red, amber, green)

product
- name
- description
- has_many: deployments
- has_many: contracts



## Installing for develompent

### Mac OSX Setup

Install [homebrew](http://brew.sh) if not on your machine.
```
brew install postgres
git clone [REPO_URL]
cd gds-infoshare
cp sample.env.txt .env
bundle
#issues compiling SSL support for puma? Try this:
gem install puma -v '2.12.1' -- --with-opt-include=/usr/local/opt/openssl/include
#Make sure Postgres is running now... (see below)
bundle exec rake db:setup
```
#### Authentication
For now, each user of the system must have her/his account manually created by an admin before they can log in. This is to prevent access by anyone within a given domain. Any Admin user can create other users and may grant or revoke admin status from other users. It is impossible to revoke your own admin status.

**NOTE:** You **MUST** create the first admin login account. It's recommended you do this via the rails console. For example, given an admin user named Peter with the email peter@somewhere.com you could do the following:
```
rails console
User.create!(name:'Peter',admin:1,email:'peter@somewhere.com')
```

To do this in production (on heroku) you'll need to start the console like so
`heroku run rails console`

## Auth Setup
- Visit the [Google developer console](https://console.developers.google.com)
- Create a new project (Name it whatever you like)
- Click "Credentials" (on the left-hand nav)
- Click on "OAuth consent screen"
- Create & save a new product
- Click "Create Credentials"
- Select "Web application"
- Provide a name (whatever you like)
- Add your local callback URI (e.g. http://localhost:5000/auth/google_oauth2/callback) to the Authorised Redirect URIs section
- Add the callback URL for production (e.g. http://app.herokuapp.com/auth/callback)
- Click Save (TWICE)
- Copy our Client ID and Secret to your `.env` file

It also has a `Procfile` which you probably won't need to touch.

### Local development
Start postgres. If you used Brew, you can run `brew install postgres` to get info on how to manually start it. Usually it looks something like this:
`pg_ctl -D /usr/local/var/postgres start`

Or, to have it run constantly in the background,
`brew services start postgresql`

To start the server use
`$ heroku local`



### Deploying to heroku

 - Set up a heroku account (or use an existing one)
 - Create a new app
 - Decide if you want to point it at your own fork of the app, a particular release, or branch, or the HEAD. For production instances, it's recommended you point it to the latest stable release.
 - Go to the "Settings" tab
 - click "reveal config vars"
 - Create new keys for GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, and any other config params set in your `.env` file


## Data backups
 TIP: Need to backup your heroku database before deploying?

 ```
 $ heroku pg:backups capture --app APPNAME
 ```

 Want daily backups?
 ` heroku pg:backups schedule DATABASE_URL --at '02:00 Europe/London' --app APPNAME`

 You can save it locally if you want:

 ```
 $ curl -o latest.dump `heroku pg:backups public-url --app APPNAME`
 ```

  Read more about [postgres backups](https://devcenter.heroku.com/articles/heroku-postgres-backups)  including how to restore.

## Testing

This app attempts to use BDD principles as much as possible. It still needs proper unit tests but in the meantime, all new functionality should be covered by integration tests. To make cucumber run for this app, here's what I have to do (after installing all the gems, etc).

### Running cucumber
`$ bundle exec cucumber`

Or only run @wip (work in progress) tests:

`$ bundle exec cucumber:wip`
