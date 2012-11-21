require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "sign up"  do
    before { visit signup_path }
    let(:submit) { "Create my account"}

    it { should have_selector('h1', text: "Sign Up")}
    it { should have_selector('title', text: full_title("Sign Up"))}

    it 'prevents invalid user from signing up' do
      #filling none of the fields in
      expect { click_button :submit }.not_to change(User, :count)
    end

    it 'allows valid user to sign up' do
      fill_in 'Name', with: "example user"
      fill_in "Email", with: "example@email.com"
      fill_in "Password", with: "foobar"
      fill_in "confirmation", with: "foobar"
      expect { click_button :submit }.to change(User, :count).by 1
    end

    describe "after submission" do
      before { click_button :submit}

      it { should have_selector 'title', text: 'Sign Up' }
      it { should have_content 'error' }
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user)}

    it {should have_selector('h1', text: user.name)}
    it {should have_selector('title', text: user.name)}
  end

end
