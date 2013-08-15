module Dragonfly
  module OpenSSL
    class Encoder
      include ::Dragonfly::Configurable
      configurable_attr :key, nil

      def encode(temp_object, format, options = {})
        throw :unable_to_handle unless [:encrypt, :decrypt].include?(format)
        throw :unable_to_handle unless key

        options[:meta] ||= {}

        original_filename = temp_object.original_filename

        temp_file = Tempfile.new(original_filename)
        temp_file.binmode
        temp_file.close

        dec = (format == :decrypt) ? '-d ' : ''

        %x{openssl enc -aes-256-cbc #{dec} -in "#{temp_object.path}" -out "#{temp_file.path}" -pass pass:"#{key}"}

        content = ::Dragonfly::TempObject.new(File.new(temp_file.path))
        meta = {
            name: original_filename,
            encrypted: (format != :decrypt)
        }.merge(options[:meta])

        [ content, meta ]
      end

    end
  end
end
