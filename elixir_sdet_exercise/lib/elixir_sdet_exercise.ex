defmodule ElixirSdetExercise do
  def hello do
    :world
    val = "Hello World!"
    IO.puts "#{val}"
  end
end

defmodule FacebookHelper do

  use Hound.Helpers

  @dummyuser %{first: "Bob",
         last: "Blaine",
         phone: "555-333-1234",
         email: "my_email@email.com",
         password: "B6$_tal2Hq5",
         birthday: "Jan 01 1990",
        }

  def isLegacyPage do

  end

  def launchFacebook do
    navigate_to("http://facebook.com")
    #assert page_title()=="Facebook - Log In or Sign Up"
  end

  def register_no_first do
    launchFacebook()

    first_name_element = find_element(:name, "firstname")
    fill_field(first_name_element, @dummyuser.first)
    submit_element(first_name_element)
  end

end
