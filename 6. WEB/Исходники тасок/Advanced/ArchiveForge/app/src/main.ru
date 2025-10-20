# frozen_string_literal: true

require 'landline'
require 'net/http'

# Utility functions for HTTP access
module HTTPHelpers
  class << self
    attr_accessor :user, :pass
  end

  # Make an HTTP POST request
  def self.post(uri, body)
    uri = URI(uri)
    Net::HTTP.start(uri.host, uri.port,
                    use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new(uri,
                                    'Content-Type' => 'application/json')
      request.body = ::JSON.dump(body)
      if HTTPHelpers.user && HTTPHelpers.pass
        request.basic_auth HTTPHelpers.user, HTTPHelpers.pass
      end
      response = http.request(request)
      response.body
    end
  end

  # Make an HTTP PUT request
  def self.put(uri, body)
    uri = URI(uri)
    Net::HTTP.start(uri.host, uri.port,
                    use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Put.new(uri,
                                   'Content-Type' => 'application/json')
      request.body = ::JSON.dump(body)
      if HTTPHelpers.user && HTTPHelpers.pass
        request.basic_auth HTTPHelpers.user, HTTPHelpers.pass
      end
      response = http.request(request)
      response.body
    end
  end

  # Make an HTTP GET request
  def self.get(uri)
    uri = URI(uri)
    Net::HTTP.start(uri.host, uri.port,
                    use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)
      request['Cookie'] = 'archiver=1Y2BFmNtYSTtGDhm;'
      if HTTPHelpers.user && HTTPHelpers.pass
        request.basic_auth HTTPHelpers.user, HTTPHelpers.pass
      end
      response = http.request(request)
      response.body
    end
  end

  # Make an HTTP DELETE request
  def self.delete(uri)
    uri = URI(uri)
    Net::HTTP.start(uri.host, uri.port,
                    use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Delete.new(uri)
      request['Cookie'] = 'archiver=1Y2BFmNtYSTtGDhm;'
      if HTTPHelpers.user && HTTPHelpers.pass
        request.basic_auth HTTPHelpers.user, HTTPHelpers.pass
      end
      response = http.request(request)
      response.body
    end
  end
end

# Main application
class App < Landline::App
  path '/api/' do
    get '/archive' do
      next 'No page url provided' unless request.query['url']

      HTTPHelpers.get(request.query['url'])
    end
  end

  handle do |status, **_extra|
    [status, { 'content-type': 'text/plain' },
     Landline::Util::HTTP_STATUS[status]]
  end
end

run App.new
