require 'httpclient'
require 'openssl'
require 'json'
require 'date'

class Website
    attr_accessor :url
    def initialize(url: '')
      @url = url
    end

    def setURL(url)
      @url = url
      puts @url
    end

    def validate

      client = HTTPClient.new
      response = client.get(@url)
      cert = response.peer_cert
      cert = OpenSSL::X509::Certificate.new(cert)
      certprops = OpenSSL::X509::Name.new(cert.issuer).to_a
      issuer = certprops.select { |name, data, type| name == "O" }.first[1]
      result = {
          URLofTheSite: @url,
          valid_on: Date.parse(cert.not_before.to_s),
          valid_until: Date.parse(cert.not_after.to_s),
          issuer: cert.issuer,
          Subject: cert.subject,
          Serial: cert.serial
          #valid: (client.verify_result == 0)
      }
      #puts validityUntil
    end
end
