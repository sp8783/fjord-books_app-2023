# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User#name_or_email should return name if user has name' do
    assert_equal 'alice', users(:alice).name_or_email
  end

  test 'User#name_or_email should return email if user do not has name' do
    assert_equal 'bob@example.com', users(:bob).name_or_email
  end
end
