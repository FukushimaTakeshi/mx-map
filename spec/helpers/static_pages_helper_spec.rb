require 'rails_helper'

RSpec.describe StaticPagesHelper, type: :helper do
  describe '#term' do
    it '利用規約を返すこと' do
      expect(term).to include('<h1>利用規約</h1>')
    end
  end
  describe '#privacy' do
    it 'プライバシーポリシーを返すこと' do
      expect(privacy).to include('<h1>プライバシーポリシー</h1>')
    end
  end
end
