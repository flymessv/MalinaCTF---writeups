# frozen_string_literal: true

require 'landline'
require 'json'

# Main application
class App < Landline::App
  path "/api/" do
    before do
      header 'content-type', 'application/json'
    end
    get "/itoc" do
      q = request.query
      unless q['inch'].to_f
        next { 'result': nil,
               'message': 'inch param required' }.to_json
      end
      next { 'result': true,
             'inch': q['inch'].to_f,
             'cm': q['inch'].to_f * 2.54 }.to_json
    end
    get "/ctoi" do
      q = request.query
      unless q['cm'].to_f
        next { 'result': nil,
               'message': 'cm param required' }.to_json
      end
      next { 'result': true,
             'inch': q['cm'].to_f / 2.54,
             'cm': q['cm'].to_f }.to_json
    end
    get "/admin" do
      next { 'result': true,
             'flag': 'SSU{R3al1y_H3lpfUl_4P1-AKSHD8213}' }.to_json
    end
    handle 404 do |_status, **_params|
      [404, { 'content-type': 'application/json' }, {
        'result': nil,
        'endpoints': {
          '/ctoi': { 'desc': 'CM to Inch', param: ["cm"] },
          '/itoc': { 'desc': 'Inch to CM', param: ["inch"] },
          '/admin': { 'desc': 'Admin commands (TODO: delete from docs)' }
        }
      }.to_json]
    end
  end
  handle do |status, backtrace: nil, **_extra|
    [status, { 'content-type': 'application/json' },
     { 'error': Landline::Util::HTTP_STATUS[status] }.to_json]
  end
end

run App.new
