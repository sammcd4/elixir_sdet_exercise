defmodule ElixirSdetExercise do
  def hello do
    :world
    val = "Hello World!"
    IO.puts "#{val}"
  end
end

defmodule FacebookHelper do

  use Hound.Helpers

  @validdata %{first: {"type", "firstname", "Bob"},
         last: {"type", "lastname", "Blaine"},
         email: {"type", "reg_email__", "my_email@email.com"},
         email_confirmation: {"type", "reg_email_confirmation__", "my_email@email.com"},
         password: {"password", "reg_passwd__", "B6$_tal2Hq5"},
         month: {"select", "month", "1"},
         day: {"select", "day", "1"},
         year: {"select", "year", "1990"},
        }

  @confirmdata %{email: {"type", "reg_email_confirmation__", "y_email@email.com"},
                }

  @invaliddata %{email: {"type", "reg_email__", "my_email@email"},
         password: {"password", "reg_passwd__", "mypassword"},
         month: {"select", "month", "month"},
         day: {"select", "day", "-1"},
         year: {"select", "year", "sixties"},
        }

  def is_legacy_page do

  end

  def launch_facebook do
    navigate_to("http://facebook.com")
  end

  def fb_type_valid_field(my_field) do
    fb_type_field(Map.get(@validdata, my_field))
    # ensure confirmation fields are filled
    #if my_field==:email do
      #fb_type_field_impl(Map.get(@confirmdata, my_field))
    #end
  end

  def fb_type_field(field_tuple) do
    element_name = find_element(:name, elem(field_tuple, 1))
    fill_field(element_name, elem(field_tuple, 2))
  end

  def select_drop_down(drop_down, option) do
    find_element(:css, "##{drop_down} option[value='#{option}']") |> click()
  end

  def fb_clear_field(my_field) do
    element_name = find_element(:name, elem(Map.get(@validdata, my_field), 1))
    clear_field(element_name)
  end

  def fb_submit_form do
    sign_up_button = find_element(:name, "websubmit")
    click(sign_up_button)
  end

  def register_no_first do
    launch_facebook()

    first_name_element = find_element(:name, "firstname")
    fill_field(first_name_element, @dummyuser.first)
    submit_element(first_name_element)
  end

  def register_valid_user do
    register_loop()
    #register_full_manual()
  end

  def register_loop do
    Enum.each  @validdata,  fn {k, v} ->
      cond do
        elem(v, 0)=="type" ->
          fb_type_valid_field(k)
        elem(v, 0)=="select" ->
          select_drop_down(k, elem(v, 2))
        true ->
          IO.puts "No match"
      end
    end
  end

  def register_full_manual do
    fb_type_field(:first)
    fb_type_field(:last)
    fb_type_field(:email)
    fb_type_field(:password)
    select_drop_down(:month, "1")
  end

end
