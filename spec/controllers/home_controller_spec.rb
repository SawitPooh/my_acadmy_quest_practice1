require 'rails_helper'

RSpec.describe "HomeController", type: :request do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /quests" do
    context "with valid parameters" do
      it "creates a new quest and redirects" do
        expect {
          post quests_path, params: { quest: { title: "เขียนเทสต์ RSpec" } }
        }.to change(Quest, :count).by(1)

        expect(response).to redirect_to(root_path)
        follow_redirect!
      end
    end

    context "with invalid parameters" do
      it "does not create a quest and renders index with error" do
        expect {
          post quests_path, params: { quest: { title: "" } }
        }.not_to change(Quest, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("กรุณากรอกข้อมูล")
      end
    end
  end
end
