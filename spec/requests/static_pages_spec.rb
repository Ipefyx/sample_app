require 'spec_helper'

describe "StaticPages" do

	let(:base_title) {"Ruby on Rails Tutorial Sample App" }

	describe "Home page" do
		before { visit root_path }
		
		it "should have the h1 'Sample App'" do
			page.should have_selector('h1', :text => 'Sample App')
		end
		
		it "should have the right title" do
			page.should have_selector('title',
				:text => "#{base_title}")
		end
		
		it "should not have a custom page title" do
			page.should_not have_selector('title', text: '| Home')
		end
	end
	
	describe "Help page" do
		before { visit help_path }
		
		it "should have the h1 'Help'" do
			page.should have_selector('h1', :text => 'Help')
		end
		
		it "should have the right title" do
			page.should have_selector('title',
				:text => full_title('Help'))
		end
	end
	
	describe "About page" do
		before { visit about_path }
	
		it "should have the h1 'About Us'" do
			page.should have_selector('h1', :text => 'About Us')
		end
		
		it "should have the right title" do
			page.should have_selector('title',
				:text => "#{base_title} | About Us")
		end
	end
	
	describe "Contact page" do
		before { visit contact_path }
		it "should have the h1 'Contact'" do
			page.should have_selector('h1', :text => 'Contact')
		end
		
		it "should have the right title" do
			page.should have_selector('title',
				:text => "#{base_title} | Contact")
		end
	end
end
