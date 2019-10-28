# example-github-apps

My GitHub Apps test repository

## Usage

1. move GitHub Apps private pem file to this repository. and rename it a private-key.pem
1. set Environment variable `export APP_ID=<Your GitHub App ID>; export=INSTALLATION_ID=<Your GitHub App Installation ID>`
1. Call JSON Web token client and note the access token

```sh
$ bundle exec ruby -e "require './json_web_token_client'; puts JsonWebTokenClient.new.call.to_json" | jq .token`
```

1. Call Create Issue Client. after that Check issues in repository

```ruby
$ bundle exec pry
[1] pry(main)> require './issue_client'
=> true
[2] pry(main)> CreateIssueClient.new(title: 'new issue via API', body: 'this issue is a post from api via json web token').call
```
