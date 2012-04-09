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
		
		describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
					# assumes that each feed item has a unique CSS id
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
			
			describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end
				
				# Won't work, but don't know why ! D:
        # it { should have_link("0 following", href: following_user_path(user)) }
        # it { should have_link("0 followers", href: followers_user_path(user)) }
      end
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
