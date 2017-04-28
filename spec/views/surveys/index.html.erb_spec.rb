require 'rails_helper'

RSpec.describe "surveys/index", type: :view do
  before(:each) do
    assign(:surveys, [
      Survey.create!(),
      Survey.create!()
    ])
  end

  it "renders a list of surveys" do
    render
  end
end
