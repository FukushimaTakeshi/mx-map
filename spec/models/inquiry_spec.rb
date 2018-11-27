require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  describe '#valid' do
    subject { Inquiry.new(title: title, email: email, message: message) }
    let(:title) { 'ほげたいとる' }
    let(:email) { 'sample@example.com' }
    let(:message) { 'ほげめっせーじ' }

    it { is_expected.to be_valid }

    context 'titleが空の場合' do
      let(:title) { '' }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:title]).to include('を入力して下さい。')
      end
    end
    context 'titleが256文字の場合' do
      let(:title) { 256.times.map { [*'a'..'z'].sample }.join }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:title]).to include('は255文字以内で入力して下さい。')
      end
    end

    context 'emailがメール形式以外の場合' do
      let(:email) { 'hoge@hoge@hoge' }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:email]).to include('は不正な値です。')
      end
    end
    context 'emailが256文字の場合' do
      let(:email) { 244.times.map { [*'a'..'z'].sample }.join + '@example.com' }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:email]).to include('は255文字以内で入力して下さい。')
      end
    end

    context 'messageが空の場合' do
      let(:message) { '' }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:message]).to include('を入力して下さい。')
      end
    end
    context 'messageが2001文字の場合' do
      let(:message) { 2001.times.map { [*'a'..'z'].sample }.join }
      it { is_expected.to_not be_valid }
      it 'エラーメッセージが出力されること' do
        subject.valid?
        expect(subject.errors[:message]).to include('は2000文字以内で入力して下さい。')
      end
    end
  end
end
