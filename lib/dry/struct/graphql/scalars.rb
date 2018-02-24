module Dry
  class Struct
    module GraphQL
      module Scalars
        def dry_type_to_graphql_scalar(type)
          if (type.kind_of?(Dry::Types::Sum))
            if type.left.type.primitive.name == 'TrueClass' and type.right.type.primitive.name == 'FalseClass'
              return ::GraphQL::BOOLEAN_TYPE
            end
            raise "Don't know how to convert #{type.inspect}"
          end

          case type.type.primitive.name
          when 'String'
            ::GraphQL::STRING_TYPE
          when 'Integer'
            ::GraphQL::INT_TYPE
          when 'Float'
            ::GraphQL::FLOAT_TYPE
          else
            raise "Don't know how to convert #{type.type.primitive.inspect}"
          end
        end
      end
    end
  end
end
