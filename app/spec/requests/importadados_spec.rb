require 'rails_helper'

RSpec.describe "Importadados", type: :request do
  describe "GET /import" do
    it "returns http success" do
      get "/importadados/import"
      expect(response).to have_http_status(:success)
    end
  end

end
