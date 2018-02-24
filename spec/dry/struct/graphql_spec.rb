RSpec.describe Dry::Struct::GraphQL do

  it "has a version number" do
    expect(Dry::Struct::GraphQL::VERSION).not_to be nil
  end

  module IntegrationSpec
    module Structs
      OtherStruct = Class.new(Dry::Struct) do
        attribute :other_attribute, Dry::Types['strict.string']
      end

      TestStruct = Class.new(Dry::Struct) do
        attribute :some_attribute, Dry::Types['strict.string']
        attribute :nested, OtherStruct
        attribute :duplicated, OtherStruct
      end
    end

    module GraphQL
      extend Dry::Struct::GraphQL

      OtherType = Structs::OtherStruct.to_graphql_object_type
      TestType = Structs::TestStruct.to_graphql_object_type

      QueryType = ::GraphQL::ObjectType.define do
        name "Query"
        field :test, TestType, "A test"
      end

      TestSchema = ::GraphQL::Schema.define do
        query QueryType
      end
    end
  end

  describe "integration example" do
    it "has all the types defined" do
      expect(IntegrationSpec::GraphQL::TestSchema.types['Query']).to_not be_nil
      expect(IntegrationSpec::GraphQL::TestSchema.types['TestStruct']).to_not be_nil
      expect(IntegrationSpec::GraphQL::TestSchema.types['OtherStruct']).to_not be_nil
    end
  end
end
