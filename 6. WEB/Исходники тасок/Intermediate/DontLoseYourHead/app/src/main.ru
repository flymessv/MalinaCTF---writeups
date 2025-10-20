# frozen_string_literal: true

require 'landline'
require 'json'

# Main application
class App < Landline::App
  get "/admin" do
    die(403, backtrace: ["Not Authorized"])
  end
  head "/admin" do
    header "x-flag", "SSU{0r_y0u_m1g4t_L05e_yoUr_H34der5-A523nBBB32}"
  end
  handle do |status, backtrace: nil, **_extra|
    [status, { 'content-type': 'text/plain' },
     Landline::Util::HTTP_STATUS[status]]
  end
end

run App.new
