require 'spec_helper'

describe "Microposts" do

	before(:each) do
		user = Factory(:user)
		visit signin_path
		fill_in	:email,			:with => user.email
		fill_in	:password,		:with => user.password
		click_button
	end
	
	describe "creation" do
	
		describe "failure" do
			
			it "should not make a new micropost" do
				lambda do 
					visit root_path
					fill_in :micropost_content, :with => ""
					click_button
					response.should render_template('pages/home')
					response.should have_selector("div#error_explanation")
				end.should_not change(Micropost, :count)
			end
		end
		
		describe "success" do
			
			it "should make a new micropost" do
				content = "Lorem ipsum dolor sit amet"
				lambda do
					visit root_path
					fill_in	:micropost_content,	:with => content
					click_button
					response.should have_selector("span.content", :content => content)
				end.should change(Micropost, :count).by(1)
			end
		end
	end	
	
	# This section of tests is a little messy. Need to think through them better. 100% added by me (Holland).
	describe "when viewing other users' microposts the user" do
	
		before(:each) do
			@user2 = Factory(:user, :email => Factory.next(:email))
			mp3 = Factory(:micropost, :user => @user2, :created_at => 1.day.ago)
		end		
		
		it "should see the posts of other users on their profile page" do	
			visit user_path(@user2.id)		
			response.should have_selector("td.micropost")
		end	
	
		it "should not see a delete link next to a micropost that does not belong to current user" do
			#code added to make sure delete link disappears appropriately, see pg. 458
			visit user_path(@user2.id)		
			response.should_not have_selector("a", :content => "delete")	
		end		
	end
end

