# Threat

Collection of useful Danger plugins which intends to help you get up and running with Danger faster

Danger itself - https://danger.systems

## Usage

All you need to do to start using Threat is:

1. Add it to your Gemfile

```ruby
group :development, :test do
  gem 'threat', require: false
end
```

2. Bundle

```sh
bundle install
```

3. Import it into your Dangerfile

```ruby
danger.import_dangerfile(gem: 'threat')
```

4. Create a GitHub workflow which will run your Dangerfile when the PR is opened/updated

```yaml
# .github/workflows/ci.yml

name: CI

on:
  pull_request:
    branches:
      - master

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

# https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token
permissions:
  actions: write
  checks: write
  contents: read
  statuses: write
  pull-requests: write

jobs:
  danger:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: 3.3.1
          bundler-cache: true

      - name: Run Danger
        env:
          DANGER_GITHUB_API_TOKEN: ${{ github.token }}
        run: bundle exec danger

```

## Available plugins

1. PR Title

Validates that the Pull Request title is in correct format, containing JIRA ticket number and a meaningful short description. This works best when combined with "use pr title" + squash and merge strategy in GitHub

```ruby
# Dangerfile

danger.import_dangerfile(gem: 'threat')

pr_title.run!
```

2. TODO

Checks if there are TODOs in PR diff. Can be improved by adding logic that will check if TODO was introduced in the PR itself, in this case warning message could be rephrased

```ruby
# Dangerfile

danger.import_dangerfile(gem: 'threat')

todo.run!
```

3. Confetti 🎉

Just add the following line at the bottom of your Dangerfile to celebrate a good run!

```ruby
# Dangerfile

danger.import_dangerfile(gem: 'threat')

# The rest of your Dangerfile goes here...

confetti.run! unless failed?
```

P.S [Raycast](https://www.raycast.com/) and macOS is required (not a paid promotion) (sorry @dhh)

## Contributing

Yes, please 🥺
