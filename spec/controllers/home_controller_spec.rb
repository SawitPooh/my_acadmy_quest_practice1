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

  describe "PATCH /quests/:id/toggle_status" do
    let!(:quest) { Quest.create!(title: "Test Quest", status: initial_status) }

    context "when toggling quest status from false to true" do
      let(:initial_status) { false }

      it "updates the status to true" do
        patch toggle_status_quest_path(quest), headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }

        expect(response).to have_http_status(:ok)
        expect(quest.reload.status).to be true
      end
    end

    context "when toggling quest status from true to false" do
      let(:initial_status) { true }

      it "updates the status to false" do
        patch toggle_status_quest_path(quest), headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }

        expect(response).to have_http_status(:ok)
        expect(quest.reload.status).to be false
      end
    end
  end

  describe "DELETE /quests/:id" do
    let!(:quest) { Quest.create!(title: "Test Quest") }
    it "deletes a quest and redirects with turboframe" do
      delete quest_path(quest), headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:ok)
      expect(Quest.exists?(quest.id)).to be false
    end
  end
end
