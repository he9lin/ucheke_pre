require File.expand_path('../test_helper', File.dirname(__FILE__))

class UchekeTest < Test::Unit::TestCase
  include Capybara::DSL
  
  def setup
    Capybara.app = ::Sinatra::Application.new
  end
  
  context "successfully send an email" do
    setup do
      visit "/"
      fill_in "Name", :with => "Superman"
      fill_in "Email", :with => "superman@example.com"
      fill_in "Content", :with => "I am superman!"
      click_button "Submit"
    end

    should "increase mails size" do
      assert_equal Mail::TestMailer.deliveries.size, 1
    end

    should "display successful message" do
      assert_equal Mail::TestMailer.deliveries.size, 1
    end
  end
end