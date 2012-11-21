require 'spec_helper'

describe "StaticPages" do

    let(:base_title) {"Sample App |"}
    subject { page }



    shared_examples_for "all static pages" do
      it { should have_selector('h1', text: heading)}
      it { should have_selector('title', text: full_title(page_title))}
    end

    describe "layout" do
     before { visit root_path}

      it "should have working About link" do
      click_link("About")
      should have_selector('title', text: 'About')
      end

      it "should have working Contact link" do
        click_link("Contact")
        should have_selector('title', text: 'Contact')
      end

      it "should have working Help link" do
        click_link("Help")
        should have_selector('title', text: 'Help')
      end

     it "should have working Home link" do
       click_link("Home")
       should have_selector('title', text: 'Home')
     end
    end

    describe "full title" do

      it "should have"

    end

  describe "Home Page" do
    before { visit root_path}
    let(:heading) { 'Sample App'}
    let(:page_title) { 'Home'}

    it_should_behave_like "all static pages"

    it {should have_selector('title', text: "Sample App")}

    it {should have_selector('title', text: full_title('')) }
  end

  describe "Help Page" do
    before { visit help_path}
    let(:heading) { 'Help'}
    let(:page_title) { 'Help'}
    it_should_behave_like "all static pages"
  end


  describe "About page" do
    before { visit about_path}
    let(:heading) {'About'}
    let(:page_title){'About'}
    it_should_behave_like "all static pages"


  end

  describe "Contact page" do
    before { visit contact_path}
    let(:heading) {'Contact'}
    let(:page_title){'Contact'}
    it_should_behave_like "all static pages"
    end

end
