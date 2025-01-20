module RailsMail
  module ApplicationCable
    class Connection < ActionCable::Connection::Base
      # identified_by :current_user

      def connect
        # self.current_user = find_verified_user
      end

      private

      def find_verified_user
        # TODO: Implement user verification
      end
    end
  end
end
