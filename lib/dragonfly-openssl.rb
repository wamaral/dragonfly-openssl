require 'dragonfly'

module Dragonfly
  module OpenSSL
    autoload :Config,  'dragonfly-openssl/config'
    autoload :Encoder, 'dragonfly-openssl/encoder'
  end
end

Dragonfly::App.register_configuration(:openssl) { Dragonfly::OpenSSL::Config }
