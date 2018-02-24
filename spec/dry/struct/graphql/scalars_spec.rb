RSpec.describe Dry::Struct::GraphQL::Scalars do
  include described_class

  shared_examples_for 'scalar' do
    it "is converted to a GraphQL Scalar" do
      gql = dry_type_to_graphql_scalar(type)
      expect(gql).to be_kind_of(GraphQL::ScalarType)
      expect(gql.name).to eq(expected_type_name)
    end
  end

  describe "String" do
    let(:type) { Dry::Types['strict.string'] }
    let(:expected_type_name) { 'String' }

    it_behaves_like "scalar"
  end

  describe "Integer" do
    let(:type) { Dry::Types['strict.int'] }
    let(:expected_type_name) { 'Int' }

    it_behaves_like "scalar"
  end

  describe "Float" do
    let(:type) { Dry::Types['strict.float'] }
    let(:expected_type_name) { 'Float' }

    it_behaves_like "scalar"
  end

  describe "Boolean" do
    let(:type) { Dry::Types['strict.bool'] }
    let(:expected_type_name) { 'Boolean' }

    it_behaves_like "scalar"
  end

end
