defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  import FacebookHelper

  # Start hound session and destroy when tests are run
  hound_session()

  def navigate_to_facebook do
    launch_facebook()
    assert page_title()=="Facebook - Log In or Sign Up"
  end

  @tag :smoke
  test "submit blank fields" do
    navigate_to_facebook()

    fb_type_valid_field(:first)
    #submit_element(first_name_element)
    fb_submit_form()
    #Process.sleep(5000)
  end

  test "without first name" do
    navigate_to_facebook()
    register_valid_user()
    fb_clear_field(:first)
  end

  test "without last name" do
    navigate_to_facebook()
    register_valid_user()
    fb_clear_field(:last)
  end

  test "no email confirmation" do

  end
end
