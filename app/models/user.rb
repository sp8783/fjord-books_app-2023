# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [150, 150]
  end

  validate :avatar_type

  private

  def avatar_type
    return unless avatar.attached?
    unless avatar.image?
      avatar.purge
      errors.add(:avatar, I18n.t('errors.messages.avatar_invalid'))
    end
  end
end
