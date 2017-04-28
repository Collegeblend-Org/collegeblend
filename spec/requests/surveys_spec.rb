require 'rails_helper'

RSpec.describe "Surveys", type: :request do
  describe "GET /surveys" do
    it "works!" do
      get surveys_path
      expect(response).to have_http_status(200)
    end
  end
end
