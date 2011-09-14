require File.expand_path('../test_helper', File.dirname(__FILE__))

class UchekeTest < Test::Unit::TestCase
  include Capybara::DSL
  
  def setup
    Capybara.app = Ucheke
    Mail::TestMailer.deliveries.clear
  end

  def fill_in_and_send_email(name="Superman", email="superman@example.com", content="I am superman!")
    visit "/"
    fill_in "name",    :with => name
    fill_in "email",   :with => email
    fill_in "content", :with => content
    click_button "submit"
  end
  
  context "successfully send an email" do
    setup do
      fill_in_and_send_email
    end

    should "increase mails size" do
      assert_equal 1, Mail::TestMailer.deliveries.size
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
  
  context "fails to send email with blank name field" do
    setup do
      fill_in_and_send_email("  ", nil)
    end
    
    should "not send email" do
      assert_equal 0, Mail::TestMailer.deliveries.size
    end

    should "display failure message" do
      assert page.has_content?('Name cannot be blank'), page.body.inspect
    end
  end

  context "fails to send email with blank content field" do
    setup do
      fill_in_and_send_email("Superman", "super@man.com", nil)
    end
  
    should "not send email" do
      assert_equal 0, Mail::TestMailer.deliveries.size
    end
  
    should "display failure message" do
      assert page.has_content?('Content cannot be blank')
    end
  end
end