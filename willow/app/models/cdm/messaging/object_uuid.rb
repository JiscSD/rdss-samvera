module Cdm
  module Messaging
    class ObjectUuid
      class << self
        def call(object)
          { objectUuid: object.id }
        end
      end
    end
  end
end