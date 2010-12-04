require 'spec_helper'

describe "LayoutLinks" do

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign Up")
  end

end
