# frozen_string_literal: true

require 'landline'
require 'mmmd'

HTML_OPTS = {
  "mapping" => {
    "PointBlank::DOM::Document" => {
      tag: nil
    }
  }
}

MARKDOWN_ROOT = "#{__dir__}/markdown/"

# Main application
class App < Landline::App
  path "/markdown/" do
    get "/content" do
      die(400) unless request.query['uri']

      page = File.exist?("#{MARKDOWN_ROOT}/#{request.query['uri']}")
      die(404) unless page

      text = File.read("#{MARKDOWN_ROOT}/#{request.query['uri']}")
      renderer = MMMD::Renderers::HTML.new(MMMD.parse(text), HTML_OPTS)
      header "content-type", "text/html"
      renderer.render
    end
    get "/list" do
      header "content-type", "application/json"
      ::Dir["#{MARKDOWN_ROOT}/*.md"].map do |filename|
        file = File.read(filename)
        {
          "title": (file.match(/^#.+$/)[0] or "Untitled"),
          "filename": filename.match(/[^\/]+$/)
        }
      end.to_json
    end
  end
  handle do |status, **_args|
    [status, { 'content-type': 'text/html' },
     Landline::Util::HTTP_STATUS[status]]
  end
end

run App.new
