# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'Report#editable? should return true if the user is the owner of the report' do
    report_of_alice = reports(:report_1)
    assert report_of_alice.editable?(users(:alice))
  end

  test 'Report#editable? should return false if the user is not the owner of the report' do
    report_of_alice = reports(:report_1)
    assert_not report_of_alice.editable?(users(:bob))
  end

  test 'Report#created_on should return the Date object when the report was created' do
    assert_instance_of Date, reports(:report_1).created_on
  end

  test 'Report#save_mentions should save mentions when new mention to report are saved' do
    new_mentioning_report = users(:carol).reports.new(title: 'This is a GOOD report!!', content: 'http://localhost:3000/reports/1')
    new_mentioning_report.save
    assert_includes reports(:report_1).mentioned_reports, new_mentioning_report
  end

  test 'When an existing mention is deleted by editing, the mention relationship should be also deleted.' do
    mentioning_report = reports(:report_2_mentioning_report_1)
    mentioning_report.content = 'deleted the mention.'
    mentioning_report.save
    assert_not_includes reports(:report_1).mentioned_reports, mentioning_report
  end
end
