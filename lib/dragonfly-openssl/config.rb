module Dragonfly
  module OpenSSL
    module Config

      def self.apply_configuration(app, opts = {})
        app.configure do |c|
          c.encoder.register(Encoder) do |e|
            e.key = opts[:key] if opts.has_key?(:key)
          end

          c.job :encrypt do |options|
            options ||= {}
            encode(:encrypt, options)
          end

          c.job :decrypt do |options|
            options ||= {}
            encode(:decrypt, options)
          end
        end
      end

    end
  end
end
