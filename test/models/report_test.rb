# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'Report#editable?' do
    report_of_alice = reports(:one)
    assert report_of_alice.editable?(users(:alice))
    assert_not report_of_alice.editable?(users(:bob))
  end

  test 'Report#created_on should return the Date object when the report was created' do
    assert_instance_of Date, reports(:one).created_on
  end

  test 'Report#save_mentions should save mentions when new mention to report are saved' do
    new_mentioning_report = users(:carol).reports.new(title: 'This is a GOOD report!!', content: 'http://localhost:3000/reports/1')
    new_mentioning_report.save
    assert_includes reports(:one).mentioned_reports, new_mentioning_report
  end

  test 'When an existing mention is deleted by editing, the mention relationship should be also deleted.' do
    mentioning_report = reports(:two_mentioning_one)
    mentioning_report.content = 'deleted the mention.'
    mentioning_report.save
    assert_not_includes reports(:one).mentioned_reports, mentioning_report
  end
end
