require File.expand_path('../test_helper', File.dirname(__FILE__))

class UchekeTest < Test::Unit::TestCase
  include Capybara::DSL
  
  def setup
    Capybara.app = Ucheke
    Mail::TestMailer.deliveries.clear
  end
  
  context "successfully send an email" do
    setup do
      visit "/"
      fill_in "name", :with => "Superman"
      fill_in "email", :with => "superman@example.com"
      fill_in "content", :with => "I am superman!"
      click_button "submit"
    end

    should "increase mails size" do
      assert_equal Mail::TestMailer.deliveries.size, 1
    end

    should "display successful message" do
      assert page.has_content?('success')
    end
    
    should "redirect to home page" do
      assert_equal '/', page.current_path
    end
    
    should "resets flash when visit home again" do
      visit "/"
      assert page.has_no_content?('success')
    end
  end
end