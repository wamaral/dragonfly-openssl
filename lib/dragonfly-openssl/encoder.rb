module Dragonfly
  module OpenSSL
    class Encoder
      include ::Dragonfly::Configurable
      configurable_attr :keyfile_path, '/tmp'

      def encode(temp_object, options = {})
        options[:meta] = {} unless options[:meta]

        original_basename = File.basename(temp_object.path, '.*')

        tempfile = Tempfile.new(original_basename)
        tempfile.binmode
        tempfile.close

        %x{openssl enc -aes-256-cbc -d -in "#{temp_object.path}" -out "#{tempfile.path}" -k "#{keyfile_path}"}

        content = ::Dragonfly::TempObject.new(File.new(tempfile.path))
        meta = {
            name: original_basename,
            encrypted: true
        }.merge(options[:meta])

        [ content, meta ]
      end

    end
  end
end