# example-github-apps

my GitHub Apps test repository

## Usage

1. move GitHub Apps private pem file to this repository. and rename it a private-key.pem
1. set Environment variable `export APP_ID=<Your GitHub App ID>; export=INSTALLATION_ID=<Your GitHub App Installation ID>`
1. Call JSON Web token client and note the access token `bundle exec ruby json_web_token_client.rb`
