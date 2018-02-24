require "graphql"
require "dry/struct"
require "dry/inflector"
require "dry/struct/graphql/version"
require "dry/struct/graphql/scalars"
require "dry/struct/graphql/structs"

module Dry
  class Struct

    def self.to_graphql_object_type
      @graphql_object_type ||= GraphQL.dry_struct_to_graphql_object_type(self)
    end

    module GraphQL
      extend Dry::Struct::GraphQL::Scalars
      extend Dry::Struct::GraphQL::Structs
      # Your code goes here...
    end
  end
end
