# frozen_string_literal: true

require 'landline'
require 'pg'
require 'json'

HOSTNAME = `cat /etc/hostname`.strip.freeze
PG_TABLE = "data"
PG_LOOKUP = "email"
PG_PARAM = {
  user: "ruby",
  dbname: "chal_db",
  password: "tez48oFltYDzEcCK",
  host: (HOSTNAME == 'major-tom' ? "172.28.0.2" : 'chal-db')
}.freeze

CONN = PG.connect(**PG_PARAM)

# Main application
class App < Landline::App
  before do
    header 'content-type', 'application/json'
  end

  get "/search" do
    searchterm = request.query['query']

    die(400) unless searchterm

    begin
      query = "SELECT * FROM #{PG_TABLE} WHERE position('#{searchterm}' in #{PG_LOOKUP})>0;"
      CONN.exec(query, &:to_a).to_json
    rescue StandardError => e
      { 'error': e.message }.to_json
    end
  end

  get "/list" do
    query = "SELECT * FROM #{PG_TABLE};"
    CONN.exec(query, &:to_a).to_json
  end

  handle do |status, **_args|
    [status, { 'content-type': 'application/json' },
     { 'error': Landline::Util::HTTP_STATUS[status] }.to_json]
  end
end

run App.new
