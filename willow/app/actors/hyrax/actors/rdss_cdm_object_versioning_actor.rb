module Hyrax
  module Actors
    class RdssCdmObjectVersioningActor < AbstractActor

      def create_default_values 
        {
          object_version: '1', 
          object_uuid:    SecureRandom.uuid
        }
      end

      public
      def create(env)
        ::Rdss::Actors::SetAttributeValuesIfBlank.(env, create_default_values)
        next_actor.create(env)
      end
      
      def update(env)
        ::Rdss::Actors::PerformCdmVersioning.(env) if CurationConcernApproved.(env) unless ObjectVersionChanged.(env)
        next_actor.update(env)
      end
    end
  end
end
