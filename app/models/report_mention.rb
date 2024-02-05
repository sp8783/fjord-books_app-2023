# frozen_string_literal: true

class ReportMention < ApplicationRecord
  belongs_to :mention_to, class_name: 'Report'
  belongs_to :mention_from, class_name: 'Report'

  validates :mention_to, presence: true
  validates :mention_from, presence: true
end
