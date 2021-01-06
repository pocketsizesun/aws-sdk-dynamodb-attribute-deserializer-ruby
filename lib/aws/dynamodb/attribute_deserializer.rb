# frozen_string_literal: true

module Aws
  module DynamoDB
    class AttributeDeserializer
      def self.call(hash)
        new.call(hash)
      end

      def call(hash)
        return unless hash.is_a?(Hash)

        hash.transform_values { |v| translate(v) }
      end

      def translate(arg)
        type, value = arg.to_a.first
        case type
        when 'N' then value.to_f
        when 'L'
          value.map { |item| translate(item) }
        when 'SS'
          Set.new(value)
        when 'NS'
          Set.new(value.map(&:to_f))
        when 'M'
          value.transform_values { |item| translate(item) }
        when 'S' then value.to_s
        when 'B' then Base64.decode64(value)
        when 'BS'
          Set.new(value.map { |item| Base64.decode64(item) })
        when 'NULL' then nil
        when 'BOOL' then value
        else value
        end
      end
    end
  end
end
