require "rails_helper"

RSpec.describe "Brag Document", type: :system do
  context "when user goes to My Brag Document" do
    before do
      visit root_path
    end

    it "can display the brag document content" do
      find('[data-testid="brag-link"]').click

      expect(page).to have_content("🧠 Goal")
      expect(page).to have_content("👤 Self:")
      expect(page).to have_content("🤝 Team:")
      expect(page).to have_content("🧪 ODT:")
      expect(page).to have_content("💼 Client:")
    end

    it "can go back to homepage from brag document" do
      find('[data-testid="brag-link"]').click

      find('[data-testid="back-button"]').click

      expect(page).to have_content("My Academy Quest")
    end
  end
end
