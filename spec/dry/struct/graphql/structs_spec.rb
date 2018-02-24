RSpec.describe Dry::Struct::GraphQL::Structs do
  describe "Simple struct" do

    let(:struct) {
      TestStruct = Class.new(Dry::Struct) do
        attribute :some_attribute, Dry::Types['strict.string']
      end
    }
    let(:graphql_type) { struct.to_graphql_object_type }

    it "converts a struct" do
      expect(graphql_type).to be_kind_of(GraphQL::ObjectType)
      expect(graphql_type.fields['some_attribute'].type).to be_kind_of(GraphQL::ScalarType)
      expect(graphql_type.fields['some_attribute'].type.name).to eq('String')
    end
  end

  describe "Nested struct" do
    let(:struct) {
      module NestedStructs
        OtherStruct = Class.new(Dry::Struct) do
          attribute :other_attribute, Dry::Types['strict.string']
        end
        TestStruct = Class.new(Dry::Struct) do
          attribute :some_attribute, Dry::Types['strict.string']
          attribute :nested, OtherStruct
          attribute :duplicated, OtherStruct
        end
      end
      NestedStructs::TestStruct
    }
    let(:graphql_type) { struct.to_graphql_object_type }

    it "converts a struct" do
      expect(graphql_type).to be_kind_of(GraphQL::ObjectType)
      expect(graphql_type.fields['some_attribute'].type).to be_kind_of(GraphQL::ScalarType)
      expect(graphql_type.fields['some_attribute'].type.name).to eq('String')
      expect(graphql_type.fields['nested'].type).to be_kind_of(GraphQL::ObjectType)
      expect(graphql_type.fields['nested'].type.fields['other_attribute'].type).to be_kind_of(GraphQL::ScalarType)
      expect(graphql_type.fields['nested'].type.fields['other_attribute'].type.name).to eq('String')

      expect(graphql_type.fields['nested'].type).to be(graphql_type.fields['duplicated'].type)
    end
  end


end

