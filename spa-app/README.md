# Sponsor A Pet App

## First time Setup

```bash
$ bundle install
```

### Prerequisites

1. Ensure you have `Ruby 3.2.0+` installed on your computer. Installation instructions [here](https://www.ruby-lang.org/en/documentation/installation/).
2. Ensure you have Postgres installed on your computer. Installation instructions [here](https://www.postgresql.org/download/).
3. Install the dependencies for the app from the root directory.

### Environment Variables

    export PORT=3000
    export HOST_URL=http://localhost:3000
    export SENDGRID_API_KEY=sk_test_abc123
    export FROM_EMAIL=pk_test_abc123
    export TEMP_PASSWORD=
    export ADMIN_EMAIL=
    export SERVICE_EMAIL=
    export SHOPIFY_DOMAIN=
    export SHOPIFY_API_VERSION=
    export SHOPIFY_ACCESS_TOKEN=
    export SHOPIFY_STOREFRONT_ACCESS_TOKEN=
    export AWS_ACCESS_KEY=
    export AWS_SECRET_KEY=
    export AWS_S3_BUCKET=

    or put them in .env file like
    PORT=3000
    HOST_URL=http://localhost:3000
    ...

    Procure all env variables and place them in a `.env` file at the root level.

### Starting Development Server
    $ ./bin/dev
    alternatively, you can create an alias in your machine's ~/.bash_profile
    $ echo "alias spadev='./bin/dev'" >> ~/.bash_profile
    reload the console and type the following to launch the server
    $ spadev

## Running the Tests

```
bundle exec rake test # runs all old MiniTest tests
ruby -Itest test/controllers/orgs_controller_test.rb # run single MiniTest file
bundle exec rspec spec/ # RSpec
```
We will use RSpec for testing.

## Contributing
1. Run `git config --global push.default simple` in your terminal once. You don't need to do it every time you contribute, just once.

2. Make sure you have latest `develop` locally:
```
git checkout develop
git pull
```

3. Create a new branch based on it:
```
git checkout -b feature/my_feature_branch
```

4. Commit and open a Pull Request

5. After code review is done and you update your branch, make sure that your Pull Requests is still mergeable.
   If there is a Github conflict with `develop`, and your branch is not merge-able anymore, pull the latest `develop` locally, then merge in your branch:
```
git checkout develop
git pull
git checkout feature/my_feature_branch
git merge develop
```

6. Fix the conflicts and push your branch. Try to fix it yourself by looking into `develop` branch changes and Trello cards, and figuring out what final behavior should do - only ask for help if you did all you could. That's because we are all not full-time yet, and waiting for someone else for help with things like this really delays features by a lot. Always try to finish the card by yourself and make sure you did the best you could to finish it.

7. Make sure your Github PR diff shows only changes relevant to your feature.

For more advanced developers I strongly encourage you to use `git rebase` instead of `merge`. Double-check that your git push behaviour is set to simple: `git config --global push.default simple`
