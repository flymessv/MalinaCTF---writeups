# frozen_string_literal: true

require 'landline'
require 'nokogiri'

# Main application
class App < Landline::App
  before do
    def prettyprint_attr(attributes)
      attributes.values.map do |attr|
        "#{attr.name}=#{attr.value.inspect}"
      end.join " "
    end

    def prettyprint_xml(xml, offset = 0)
      output = ""
      xml.children.each do |child|
        next unless child.is_a? Nokogiri::XML::Element

        output += "#{' ' * offset}#{child.name} [#{prettyprint_attr(child.attributes)}]\n"
        output += "#{' ' * offset}  #{child.text.inspect}\n" unless child.text.strip.empty?
        output += prettyprint_xml(child, offset + 2)
      end
      output
    end
  end

  post "/api/" do
    header "content-type", "application/json"
    next '{"error": "form data missing"}' unless form?

    data = form
    next '{"error": "xml field missing"}' unless data['xml']

    doc = Nokogiri::XML(data['xml'].tempfile.open) do |config|
      config.nonoent
      config.dtdload
      config.dtdvalid
    end
    { 'output': prettyprint_xml(doc) }.to_json
  end

  handle do |status, **_args|
    [status, { 'content-type': 'application/json' },
     { 'error': Landline::Util::HTTP_STATUS[status] }.to_json]
  end
end

run App.new
