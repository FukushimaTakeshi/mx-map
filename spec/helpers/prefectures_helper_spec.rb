require 'rails_helper'

RSpec.describe PrefecturesHelper, type: :helper do
  describe '#half_or_full_star' do
    context 'decimal_partが3~7の場合' do
      it 'calss属性がfa-star-halfであること' do
        expect(half_or_full_star(3)).to eq '<span class="icon mdi-18px has-text-success"><i class="fas fa-star-half"></i></span>'
        expect(half_or_full_star(4)).to eq '<span class="icon mdi-18px has-text-success"><i class="fas fa-star-half"></i></span>'
        expect(half_or_full_star(5)).to eq '<span class="icon mdi-18px has-text-success"><i class="fas fa-star-half"></i></span>'
        expect(half_or_full_star(6)).to eq '<span class="icon mdi-18px has-text-success"><i class="fas fa-star-half"></i></span>'
        expect(half_or_full_star(7)).to eq '<span class="icon mdi-18px has-text-success"><i class="fas fa-star-half"></i></span>'
      end
    end
    context 'decimal_partが8~9の場合' do
      it 'calss属性がfa-starであること' do
        expect(half_or_full_star(8)).to eq '<span class="icon mdi-18px has-text-success"><i class="fas fa-star"></i></span>'
        expect(half_or_full_star(9)).to eq '<span class="icon mdi-18px has-text-success"><i class="fas fa-star"></i></span>'
      end
    end
    context 'decimal_partが3~9以外の場合' do
      it 'calss属性がfa-starであること' do
        expect(half_or_full_star(1)).to eq nil
      end
    end
  end
end
