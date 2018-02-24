module Dry
  class Struct
    module GraphQL
      module Structs
        def dry_type_to_graphql_type(type)
          if type.respond_to? :to_graphql_object_type
            type.to_graphql_object_type
          else
            dry_type_to_graphql_scalar(type)
          end
        end

        def dry_struct_to_graphql_object_type(struct)
          inflector = Dry::Inflector.new

          fields = struct.schema.map do |name, definition|
            [name, dry_type_to_graphql_type(definition)]
           end
          ::GraphQL::ObjectType.define do
            name inflector.demodulize(struct.name)

            fields.each do |(name, type)|
              field name, type
            end
          end
        end
      end
    end
  end
end
