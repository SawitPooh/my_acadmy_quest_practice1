require 'rails_helper'

RSpec.describe "Quest management", type: :system do
  context "when user adds a new quest" do
    it "allows user to add a new quest" do
      visit root_path

      # กรอกข้อความในช่อง input
      fill_in "เพิ่มเควสต์ของฉัน", with: "กินข้าวกับแม่"

      # กดปุ่ม Add
      find('[data-testid="submit-quest"]').click

      # ตรวจสอบว่า Quest ใหม่แสดงผลในหน้าจอ
      expect(page).to have_content("กินข้าวกับแม่")
    end
  end

  context "when user toggles quest status" do
    let(:quest_title) { "อ่านหนังสือ" }

    before do
      Quest.create!(title: quest_title, status: false)
      visit root_path
    end

    it "checkbox true quest will have line-through" do
      # คลิก checkbox
      find('[data-testid^="checkbox-quest"]').click

      # ตรวจสอบว่า title มี class line-through
      expect(page).to have_selector("label.line-through", text: quest_title)
    end

    it "checkbox false quest will not have line-through" do
      # ยังไม่กด checkbox
      expect(page).to have_selector("label:not(.line-through)", text: quest_title)
    end
  end
end
