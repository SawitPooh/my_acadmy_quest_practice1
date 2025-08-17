require 'rails_helper'

RSpec.describe Quest, type: :model do
  describe 'validations' do
    it 'is valid with a title' do
      quest = Quest.new(title: 'เรียนรู้ RSpec')
      expect(quest).to be_valid
    end

    it 'is invalid without a title' do
      quest = Quest.new(title: nil)
      expect(quest).not_to be_valid
      expect(quest.errors[:title]).to include("กรุณากรอกข้อมูล")
    end
  end
end
