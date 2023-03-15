# frozen_string_literal: true
class AuthorizationKey < ApplicationRecord
  belongs_to :authable, polymorphic: true

  def expired?
    expiry.to_i < Time.now.to_i
  end
end
