# coding: utf-8

require 'rack'
require 'rack-post_body_msgpack_parser'
require 'sinatra/base'
require 'oj'

require_relative '../DodontoF_WebSet/public_html/DodontoF/src_ruby/config'
require_relative 'rack_deflater'
require_relative 'customized_server'

Oj.default_options = {mode: :compat}

DIR_PATH = File.expand_path('../DodontoF_WebSet/public_html/DodontoF', File.dirname(__FILE__)).freeze

$SAVE_DATA_DIR = "./DodontoF_WebSet".freeze
$loginCountFileFullPath = File.join($SAVE_DATA_DIR, 'saveData', $loginCountFile).freeze

$imageUploadDir = "./DodontoF_WebSet/public_html/imageUploadSpace".freeze

#TODO webif未着手

class DodontoFRackApp < Sinatra::Base

  configure do
    mime_type :msgpack, 'application/x-msgpack'
  end

  use Rack::PostBodyMsgpackParser, override_params: true
  use Hardwired::Deflater, min_length: $gzipTargetSize if 0 < $gzipTargetSize

  helpers do
    def server(params)
      @server = DodontoF::Server.new(params)

      content_type :json, charset:'utf-8'
      @server.response_body
    end
  end

  get '/image/*' do
    send_file File.join(DIR_PATH, 'image', params[:splat])
  end

  get '/imageUploadSpace/*' do
    send_file File.join(DIR_PATH, $imageUploadDir, params[:splat])
  end

  get '/DodontoF.swf' do
    send_file File.join(DIR_PATH, 'DodontoF.swf')
  end

  get '/favicon.ico' do
    send_file File.join(DIR_PATH, 'favicon.ico')
  end

  get '/' do
    send_file File.join(DIR_PATH, 'index.html')
  end

  post '/api/:webif' do
    server(params)
  end

  post '/DodontoFServer.rb' do
    server(params)
  end

end
