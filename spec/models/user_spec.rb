require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    it '正常な状態であること' do
      expect(FactoryBot.build(:user)).to be_valid
    end
    
    context 'emailが空の場合' do
      it '未入力のエラーメッセージが出力されること' do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include('を入力して下さい。')
      end
    end

    context 'emailが重複する場合' do
      before do
        user = FactoryBot.build(:user, email: 'sample@example.com')
        user.skip_confirmation!
        user.save!
      end
      it '重複のエラーメッセージが出力されること' do
        user = FactoryBot.build(:user, email: 'sample@example.com')
        user.valid?
        expect(user.errors[:email]).to include('は既に存在します。')
      end
    end
  end
end
