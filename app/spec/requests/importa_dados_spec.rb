require 'rails_helper'

RSpec.describe "ImportaDados", type: :request do
  describe "GET /import" do
    it "returns http success" do
      get "/importa_dados/import"
      expect(response).to have_http_status(:success)
    end
  end

end
