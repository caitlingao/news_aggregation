# frozen_string_literal: true

class Topic
  module Actions
    extend ActiveSupport::Concern

    included do
      enum grade: { normal: 0, excellent: 1 }

      def excellent!
        update!(grade: :excellent)
      end

      def unexcellent!
        update!(grade: :normal)
      end

    end

    # 删除并记录删除人
    def destroy_by(user)
      return false if user.blank?
      update_attribute(:who_deleted, user.login)
      destroy
    end

    def destroy
      super
    end
  end
end
