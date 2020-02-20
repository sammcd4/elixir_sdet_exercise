defmodule ElixirSdetExerciseTest do
  # Import helpers
  use Hound.Helpers
  use ExUnit.Case
  #use FacebookHelper

  # Start hound session and destroy when tests are run
  hound_session()

  @validdata %{first: {"firstname", "Bob"},
         last: {"lastname", "Blaine"},
         phone: {"reg_email__", "555-333-1234"},
         email: {"reg_email__", "my_email@email.com"},
         password: {"reg_passwd__", "B6$_tal2Hq5"},
         birthday_month: {"birthday_month", "Jan"},
         birthday_day: {"birthday_day", "01"},
         birthday_year: {"birthday_year", "1990"},
        }

  def navigateToFacebook do
    navigate_to("http://facebook.com")
    assert page_title()=="Facebook - Log In or Sign Up"
  end

  def submitFacebookForm do
    sign_up_button = find_element(:name, "websubmit")
    click(sign_up_button)
  end

  def clear_element_field(element_name) do
    element = find_element(:name, element_name)
    clear_field(element)
  end

  def register_valid_user do
    register_loop(0)
  end

  def register_loop(n) do
    if n < 8 do
      fielddata = elem(@validdata, n)
      element_name = elem(fielddata, 0)
      element_value = elem(fielddata, 1)

      # fill single element with valid data
      first_name_element = find_element(:name, element_name)
      fill_field(first_name_element, element_value)

      register_loop(n+1)
    end
  end

  @tag :smoke
  test "submit blank fields" do
    navigateToFacebook()

    first_name_element = find_element(:name, elem(@validdata.first, 0))
    fill_field(first_name_element, "FirstName")
    #submit_element(first_name_element)
    submitFacebookForm()
    #Process.sleep(5000)
  end

  test "without first name" do
    navigateToFacebook()

    #register_valid_user()

    #first_name_element = find_element(:name, "firstname")
    #fill_field(first_name_element, "FirstName")
    #Process.sleep(5000)
    clear_element_field(elem(@validdata.first, 0))
    #submit_element(first_name_element)

    #Process.sleep(5000)
  end
end
