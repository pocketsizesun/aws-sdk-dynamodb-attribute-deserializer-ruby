require "bundler/setup"
require "aws-sdk-dynamodb-attribute-deserializer"

describe Aws::DynamoDB::AttributeDeserializer do
  it "should decode DynamoDB attributes to Ruby values" do
    attributes = {
      'partition_key' => { 'S' => 'test' },
      'sort_key' => { 'N' => '123456.5444587778511245' }
    }

    item = Aws::DynamoDB::AttributeDeserializer.call(attributes)
    expect(item['partition_key']).to eql('test')
    expect(item['sort_key']).to eql(BigDecimal('123456.5444587778511245'))
  end
end
