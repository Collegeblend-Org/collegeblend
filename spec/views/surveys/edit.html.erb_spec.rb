require 'rails_helper'

RSpec.describe "surveys/edit", type: :view do
  before(:each) do
    @survey = assign(:survey, Survey.create!())
  end

  it "renders the edit survey form" do
    render

    assert_select "form[action=?][method=?]", survey_path(@survey), "post" do
    end
  end
end
