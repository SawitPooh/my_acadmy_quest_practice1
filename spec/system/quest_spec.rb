require 'rails_helper'

RSpec.describe "Quest management", type: :system do
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
