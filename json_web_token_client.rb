require 'faraday'
require 'jwt'
require 'openssl'

require './constants'

class JsonWebTokenClient
  JWT_ALGORITHM = 'RS256'.freeze

  def initialize
    @client = Faraday.new(url: access_token_url)
  end

  def call
    result = @client.post do |request|
      request.headers['Authorization'] = "Bearer #{json_web_token}".freeze
      request.headers['Accept'] = 'application/vnd.github.machine-man-preview+json'.freeze
    end

    JSON.parse(result.body, symbolize_names: true)
  end

  private def access_token_url
    @access_token_url ||= "https://api.github.com/installations/#{ENV['INSTALLATION_ID']}/access_tokens".freeze
  end

  private def json_web_token
    JWT.encode(payload, private_key, JWT_ALGORITHM)
  end

  ##########################
  # example: https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#authenticating-as-a-github-app
  #########################
  private def payload
    {
      # issued at time
      iat: Time.now.to_i,
      # JWT expiration time (10 minute maximum)
      exp: Time.now.to_i + (10 * 60),
      # GitHub App's identifier
      iss: ENV['APP_ID'],
    }
  end

  private def private_key
    @private_key ||= OpenSSL::PKey::RSA.new(File.read(Constants::PEM_FILE_PATH))
  end
end