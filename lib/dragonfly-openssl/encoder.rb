module Dragonfly
  module OpenSSL
    class Encoder
      include ::Dragonfly::Configurable
      configurable_attr :key, nil

      def encode(temp_object, format, options = {})
        throw :unable_to_handle unless [:encrypt, :decrypt].include?(format)
        throw :unable_to_handle unless key

        options[:meta] ||= {}

        original_basename = File.basename(temp_object.path)

        temp_file = Tempfile.new(original_basename)
        temp_file.binmode
        temp_file.close

        dec = (format == :decrypt) ? '-d ' : ''

        %x{openssl enc -aes-256-cbc #{dec} -in "#{temp_object.path}" -out "#{tempfile.path}" -k "#{key}"}

        content = ::Dragonfly::TempObject.new(File.new(temp_file.path))
        meta = {
            name: original_basename,
            encrypted: (format != :decrypt)
        }.merge(options[:meta])

        [ content, meta ]
      end

    end
  end
end
