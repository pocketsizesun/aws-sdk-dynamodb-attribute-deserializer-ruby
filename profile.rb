require 'bundler/setup'
require "aws-sdk-dynamodb-attribute-deserializer"
require "memory_profiler"

attributes = {
  'partition_key' => { 'S' => 'test' },
  'sort_key' => { 'N' => '123456.5444587778511245' }
}

items = []
report = MemoryProfiler.report do
  100.times do
    items << Aws::DynamoDB::AttributeDeserializer.call(attributes)
  end
end

report.pretty_print
