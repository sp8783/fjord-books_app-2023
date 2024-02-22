# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'

    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'Hi'
    fill_in '内容', with: 'best regards'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'タイトル: Hi'
    assert_text '内容: best regards'
  end

  test 'should update Report' do
    visit report_url(@report)
    assert_text 'タイトル: Hello World'
    assert_text '内容: This is the first report'

    click_on 'この日報を編集'

    fill_in 'タイトル', with: 'Modified Title'
    fill_in '内容', with: 'Modified Content'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'タイトル: Modified Title'
    assert_text '内容: Modified Content'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_button 'この日報を削除'

    assert_text '日報が削除されました。'
    assert_no_selector 'p', exact_text: "タイトル: #{@report.title}"
  end
end
