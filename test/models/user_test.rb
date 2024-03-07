# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'name_or_email' do
    assert_equal 'alice', users(:alice).name_or_email

    users(:alice).name = nil
    assert_equal 'alice@example.com', users(:alice).name_or_email
  end
end
