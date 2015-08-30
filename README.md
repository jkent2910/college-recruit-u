# College Recruit U Rails app

This is the College Recruit U Rails application.

## System dependencies

### Amazon S3

This app uses the [Paperclip gem](https://github.com/thoughtbot/paperclip) to manage attachments (images) which are stored on Amazon S3.

Amazon S3 bucket names and credentials go in `config/s3.yml`. See `config/s3.yml.example` for examples.

### Google Drive

Data for colleges is managed on Google Drive and moved to the application database via a Rake task.

The main college data is in a Google Spreadsheet named `colleges_production` and college logos and photos are in Google Drive folders named `logos` and `photos` in the same folder as the spreadsheet. These files must be shared (read-only) with a Google API service account.

Credentials for the service account go in `config/google_college_credentials.json`. See `config/google_college_credentials.json.example` for an example.

Run

````bash
$ rake cru:update_colleges
````

to update the colleges and photos database tables. Run this task on the server with `RAILS_ENV=production` to update the production database.

## Database setup

This app uses a PostgreSQL database.

To create development and test databases, make sure PostgreSQL is running and then run

````bash
$ rake db:create
````

## Running tests

The run the specs

````bash
$ rake spec
````

To run the Cucumber features

````bash
$ rake cucumber
````

## Deployment

This app is deployed on [EngineYard](https://www.engineyard.com/).

The files `config/google_college_credentials.json` and `config/s3.yml` should be copied manually to `/data/collegerecruitu/shared/config` on the EngineYard server. Also, a production `config/secrets.yml` should be created in `data/collegerecruitu/shared/config`.

These will be symlinked into the app's `config` directory upon deployment by the `deploy/before_migrate.rb` deployment hook.

EngineYard deployment settings are in `config/ey.yml`.

We deploy the `production` branch.
