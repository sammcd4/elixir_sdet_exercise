defmodule FacebookHelper do

  use Hound.Helpers

  @validdata %{first: {"type", "firstname", "Bob"},
         last: {"type", "lastname", "Blaine"},
         email: {"type", "reg_email__", "my_email@email.com"},
         email_confirmation: {"type", "reg_email_confirmation__", "my_email@email.com"},
         password: {"type", "reg_passwd__", "B6$_tal2Hq5"},
         month: {"select", "month", "1"},
         day: {"select", "day", "1"},
         year: {"select", "year", "1990"},
         gender: {"radio", "2", "Male"},
        }

  @invaliddata %{email: {"type", "reg_email__", "my_email@email"},
         email_confirmation: {"type", "reg_email_confirmation__", "my_email@emal"},
         password: {"password", "reg_passwd__", "mypassword"},
         month: {"select", "month", "0"},
         day: {"select", "day", "0"},
         year: {"select", "year", "0"},
        }

  def is_legacy_page do

  end

  def launch_facebook do
    navigate_to("http://facebook.com")
    refresh_page()
  end

  def fb_type_valid_field(my_field) do
    fb_type_field(Map.get(@validdata, my_field))
  end

  def fb_type_invalid_field(my_field) do
    fb_type_field(Map.get(@invaliddata, my_field))
  end

  def fb_type_field(field_tuple) do
    element = find_element(:name, elem(field_tuple, 1))
    fill_field(element, elem(field_tuple, 2))
  end

  def fb_click_field(my_field) do
    element = find_element(:name, elem(Map.get(@validdata, my_field), 1))
    click(element)
  end

  def fb_get_field_contents(my_field) do
    element = find_element(:name, elem(Map.get(@validdata, my_field), 1))
    visible_text(element)
  end

  def fb_field_has_error(my_field) do
    _element = find_element(:name, elem(Map.get(@validdata, my_field), 1))
    true # didn't have time to implement
  end

  def fb_select_has_error(_drop_down) do
    #element = find_element(:css, "##{drop_down} option[value='#{option}']")
    true # didn't have time to implement
  end

  def select_valid_drop_down(drop_down) do
    option = elem(Map.get(@validdata, drop_down), 2)
    select_drop_down(drop_down, option)
  end

  def select_invalid_drop_down(drop_down) do
    option = elem(Map.get(@invaliddata, drop_down), 2)
    select_drop_down(drop_down, option)
  end

  def select_drop_down(drop_down, option) do
    find_element(:css, "##{drop_down} option[value='#{option}']") |> click()
  end

  def select_radio_button(radio_value) do
    element = find_element(:css, "input[value='#{radio_value}']")
    click(element)
  end

  def fb_clear_field(my_field) do
    element_name = find_element(:name, elem(Map.get(@validdata, my_field), 1))
    clear_field(element_name)
  end

  def fb_submit_form do
    sign_up_button = find_element(:name, "websubmit")
    click(sign_up_button)

    # optional
    #take_screenshot()
    #Process.sleep(2000)
  end

  def register_valid_user do
    Enum.each  @validdata,  fn {k, v} ->
      cond do
        elem(v, 0)=="type" ->
          fb_type_valid_field(k)
        elem(v, 0)=="select" ->
          select_drop_down(k, elem(v, 2))
        elem(v, 0)=="radio" ->
          select_radio_button(elem(v, 1))
        true ->
          IO.puts "No match"
      end
    end
  end

end
