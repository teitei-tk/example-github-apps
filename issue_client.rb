require 'faraday'

require './constants'
require './json_web_token_client'

###########################################
# api document: https://developer.github.com/v3/issues/#create-an-issue
###########################################
class CreateIssueClient
  def initialize(title:, body:, assignees: [], labels: [])
    @title = title
    @body = body
    @assignees = assignees
    @labels = labels

    @client = Faraday.new(url: api_endpoint_url)
    @jwt_client = JsonWebTokenClient.new
  end

  def call
    result = @client.post do |request|
      request.headers['Authorization'] = "token #{access_token}".freeze
      request.headers['Accept'] = 'application/vnd.github.symmetra-preview+json'.freeze

      request.body = payload.to_json
    end

    JSON.parse(result.body, symbolize_names: true)
  end

  private def payload
    {
      title: @title,
      body: @body,
      assignees: @assignees,
      labels: @labels,
    }
  end

  private def api_endpoint_url
    "https://api.github.com/repos/#{Constants::OWNER_NAME}/#{Constants::REPOSITORY_NAME}/issues".freeze
  end

  private def access_token
    ret = @jwt_client.call
    ret[:token]
  end
end
