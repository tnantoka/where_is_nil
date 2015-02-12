require 'test_helper'

class WhereIsNilTest < ActiveSupport::TestCase
  setup do
    1.upto(3) { |i| User.create!(id: i) }
  end

  teardown do
    WhereIsNil.config.init
  end

  test 'Sanity' do
    assert_kind_of Module, WhereIsNil
  end

  test 'Version' do
    assert WhereIsNil.const_defined?(:VERSION)
  end

  test 'Default settings' do
    assert WhereIsNil.config.enabled
    assert WhereIsNil.config.warning_log
    assert WhereIsNil.config.raise_error
    assert_equal false, WhereIsNil.config.not_found
  end

  test 'config.enabled' do
    WhereIsNil.config.enabled = false
    assert_equal User.first, User.find_by(nil)
    assert_equal User.first, User.find_by!(nil)
    assert_equal User.first, User.where(id: [1..3]).find_by(nil)
    assert_equal User.first, User.where(id: [1..3]).find_by!(nil)

    WhereIsNil.config.enabled = true
    assert_raises(WhereIsNil::FindByNil) { User.find_by(nil) }
    assert_raises(WhereIsNil::FindByNil) { User.find_by!(nil) }
    assert_raises(WhereIsNil::FindByNil) { User.where(id: [1..3]).find_by(nil) }
    assert_raises(WhereIsNil::FindByNil) { User.where(id: [1..3]).find_by!(nil) }
  end

  test 'config.warning_log' do
    WhereIsNil.config.raise_error = false

    message = 'Why do you find by nil? Did you mean `find_by(id: nil)`?'
    logger = MiniTest::Mock.new.expect(:warn, nil, [message])
    WhereIsNil.logger = logger

    WhereIsNil.config.warning_log = false
    User.find_by(nil)
    assert_raises(MockExpectationError) { logger.verify }

    WhereIsNil.config.warning_log = true
    User.find_by(nil)
    assert logger.verify
  end

  test 'config.raise_error' do
    WhereIsNil.config.raise_error = false
    assert_equal User.first, User.find_by(nil)

    WhereIsNil.config.raise_error = true
    assert_raises(WhereIsNil::FindByNil) { User.find_by(nil) }
  end

  test 'config.not_found' do
    WhereIsNil.config.raise_error = false

    WhereIsNil.config.not_found = false
    assert_equal User.first, User.find_by(nil)
    assert_equal User.first, User.find_by!(nil)
    assert_equal User.first, User.where(id: [1..3]).find_by(nil)
    assert_equal User.first, User.where(id: [1..3]).find_by!(nil)

    WhereIsNil.config.not_found = true
    assert_nil User.find_by(nil)
    assert_raises(ActiveRecord::RecordNotFound) { User.find_by!(nil) }
    assert_nil User.where(id: [1..3]).find_by(nil)
    assert_raises(ActiveRecord::RecordNotFound) { User.where(id: [1..3]).find_by!(nil) }
  end
end
