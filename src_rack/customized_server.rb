# coding: utf-8

require 'msgpack'
require 'oj'

require_relative '../DodontoF_WebSet/public_html/DodontoF/DodontoFServer.rb'

module DodontoF

  # versionをcustomized_serverが対応している版に固定
  LATEST_VERSION = VERSION.freeze
  LATEST_DATE = RELEASE_DATE.freeze
  $version = "#{LATEST_VERSION}(#{LATEST_DATE})"

  class Server < DodontoFServer
    def initialize(params)
      params ||= {}
      super(SaveDirInfo.new, params)
      @body = getResponse
    end

    def getTextFromJsonData(json)
      Oj.dump json
    end

    def getJsonDataFromText(text)
      Oj.load text
    end

    def getMessagePackFromData(data)
      MessagePack.unpack data
    end

    def getDataFromMessagePack(data)
      MessagePack.pack data
    end

    def analyzeCommand
      cmd = getRequestData('cmd')

      return getResponseTextWhenNoCommandName unless cmd

      self.send(cmd)
    end

    def method_missing(name)
      throw Exception.new("[#{name}] is invalid command")
    end

    def response_body
      if jsonpCallBack
        "#{jsonpCallBack}(\"#{@body}\");"
      else
        @body
      end
    end
  end
end
