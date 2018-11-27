require 'rails_helper'

RSpec.describe OffRoadCircuit, type: :model do
  describe '#valid' do
    subject { FactoryBot.build(:off_road_circuit, prefecture_id: prefecture_id, region_id: region_id) }
    let(:prefecture_id) { 1 }
    let(:region_id) { 1 }

    it { is_expected.to be_valid }

    context 'nameが空の場合' do
      subject { FactoryBot.build(:off_road_circuit, name: '', prefecture_id: prefecture_id, region_id: region_id) }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:name]).to include('を入力して下さい。')
      end
    end
    context 'place_idが空の場合' do
      subject { FactoryBot.build(:off_road_circuit, place_id: '', prefecture_id: prefecture_id, region_id: region_id) }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:place_id]).to include('を入力して下さい。')
      end
    end
    context 'prefecture_idが空の場合' do
      let(:prefecture_id) { '' }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:prefecture_id]).to include('を入力して下さい。')
      end
    end
    context 'region_idが空の場合' do
      let(:region_id) { '' }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:region_id]).to include('を入力して下さい。')
      end
    end
  end
end
