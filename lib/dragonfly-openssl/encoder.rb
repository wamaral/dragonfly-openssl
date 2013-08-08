module Dragonfly
  module OpenSSL
    class Encoder
      include ::Dragonfly::Configurable
      configurable_attr :keyfile_path, nil

      def encode(temp_object, format, options = {})
        throw :unable_to_handle if keyfile_path.nil?

        options[:meta] = {} unless options[:meta]

        original_basename = File.basename(temp_object.path, '.*')

        tempfile = Tempfile.new(original_basename)
        tempfile.binmode
        tempfile.close

        %x{openssl enc -aes-256-cbc -in "#{temp_object.path}" -out "#{tempfile.path}" -k "#{keyfile_path}"}

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
