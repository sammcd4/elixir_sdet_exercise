defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  import FacebookHelper

  # Start hound session and destroy when tests are run
  hound_session()

  ## Verification methods
  def assert_login_page do
    assert page_title()=="Facebook - Log In or Sign Up"
  end

  def assert_field_error(my_field) do
    assert fb_field_has_error(my_field)
  end

  def assert_select_error(my_field) do
    assert fb_select_has_error(my_field)
  end

  def negtest_missing_field(my_field) do
    launch_facebook()

    # fill form with valid data
    register_valid_user()

    # remove data from specified field
    fb_clear_field(my_field)
    fb_submit_form()

    # verification
    assert_field_error(my_field)
    assert_login_page()
  end

  def negtest_type_invalid_field(my_field) do
    launch_facebook()

    # type invalid entry
    fb_type_invalid_field(my_field)
    fb_submit_form()

    # verification
    assert_field_error(my_field)
    assert_login_page()
  end

  def negtest_select_invalid_drop_down(drop_down) do
    launch_facebook()

    # type invalid entry
    select_invalid_drop_down(drop_down)
    fb_submit_form()

    # verification
    assert_select_error(drop_down)
    assert_login_page()
  end

  @tag single_missing: false
  test "submit blank fields" do
    launch_facebook()
    fb_submit_form()
    assert_login_page()
  end

  @tag single_missing: true
  test "missing first name" do
    negtest_missing_field(:first)
  end

  @tag single_missing: true
  test "missing last name" do
    negtest_missing_field(:last)
  end

  @tag single_missing: true
  test "missing email" do
    negtest_missing_field(:email)
  end

  @tag single_missing: true
  test "missing password" do
    negtest_missing_field(:password)
  end

  @tag unit: true
  @tag invalid: true
  test "invalid email confirmation" do
    launch_facebook()
    fb_type_valid_field(:email)
    fb_type_invalid_field(:email_confirmation)
    fb_submit_form()

    assert_field_error(:email_confirmation)
    assert_login_page()
  end

  @tag unit: true
  @tag invalid: true
  test "invalid password" do
    negtest_type_invalid_field(:password)
  end

  @tag unit: true
  @tag invalid: true
  test "invalid birthday month" do
    negtest_select_invalid_drop_down(:month)
  end

  @tag unit: true
  @tag invalid: true
  test "invalid birthday day" do
    negtest_select_invalid_drop_down(:day)
  end

  @tag unit: true
  @tag invalid: true
  test "invalid birthday year" do
    negtest_select_invalid_drop_down(:year)
  end
end
