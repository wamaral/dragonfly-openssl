module Dragonfly
  module OpenSSL
    module Config

      def self.apply_configuration(app, opts = {})
        app.configure do |c|
          c.encoder.register(Encoder) do |e|
            e.keyfile_path = opts[:keyfile_path] if opts.has_key?(:keyfile_path)
          end

          c.job :encrypt do |options|
            options ||= {}
            encode(options)
          end
        end
      end

    end
  end
end
