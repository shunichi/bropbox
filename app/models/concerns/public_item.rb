module PublicItem
  extend ActiveSupport::Concern

  included do
    attr_accessor :email

    validates :access_token, presence: true
    validates :email, presence: true

    before_validation :set_access_token

    def set_access_token
      self.access_token = SecureRandom.base64(20)
    end
  end
end
