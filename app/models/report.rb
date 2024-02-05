# frozen_string_literal: true

class Report < ApplicationRecord
  REPORT_REGEX = %r{http://localhost:3000/reports/(\d+)}

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_references, class_name: 'ReportMention', foreign_key: 'mention_to_id', dependent: :destroy, inverse_of: :mention_to
  has_many :mentioning_reports, through: :mentioning_references, source: :mention_from

  has_many :mentioned_references, class_name: 'ReportMention', foreign_key: 'mention_from_id', dependent: :destroy, inverse_of: :mention_from
  has_many :mentioned_reports, through: :mentioned_references, source: :mention_to

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def save_report_and_mentioning_references
    transaction do
      raise ActiveRecord::Rollback unless save

      create_mentioning_references
    end
  end

  def update_report_and_mentioning_references(report_params)
    transaction do
      raise ActiveRecord::Rollback unless update(report_params)

      mentioning_references.destroy_all
      create_mentioning_references
    end
  end

  def create_mentioning_references
    mention_from_ids = content.scan(REPORT_REGEX).flatten.uniq.map(&:to_i)
    mention_from_ids.each do |mention_from_id|
      mentioning_references.create!(mention_from_id:)
    end
  end
end
