require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) do
    user = FactoryBot.build(:user)
    user.skip_confirmation!
    user.save!
    sign_in user
    user
  end

  describe 'GET #index' do
    context 'リクエストされたデータが存在する場合' do
      before { get :show, params: { id: user.id } }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'showテンプレートを返すこと' do
        expect(response).to render_template(:show)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:user)).to eq user
      end
    end
    context 'リクエストされたデータが存在しない場合' do
      before { get :show, params: { id: user.id + 1 } }
      it 'リダイレクトされること' do
        expect(response).to redirect_to user_path(user)
      end
    end
  end

  describe 'GET #edit' do
    context 'リクエストされたデータが存在する場合' do
      before { get :edit, params: { id: user.id } }
      it 'httpステータス200が返ること' do
        expect(response).to have_http_status(200)
      end
      it 'editテンプレートを返すこと' do
        expect(response).to render_template(:edit)
      end
      it 'インスタンス変数が設定されていること' do
        expect(assigns(:user)).to eq user
      end
    end
    context 'リクエストされたデータが存在しない場合' do
      before { get :edit, params: { id: user.id + 1 } }
      it 'リダイレクトされること' do
        expect(response).to redirect_to user_path(user)
      end
    end
  end

  describe 'PATCH #update' do
    let(:params) do
      { user:
        { username: 'username',
          avatar: 'hoge',
          mx_profile_attributes: {
            mx_history_id: 1,
            license_id: 1
          }
        }
      }
    end

    context 'リクエストされたデータが存在する場合' do
      context 'パラメータが正しい場合' do
        context 'MxProfileにデータがない場合' do
          subject { patch :update, params: { id: user.id }.merge(params) }
          it 'httpステータス302が返ること' do
            is_expected.to have_http_status(302)
          end
          it 'リダイレクトされること' do
            is_expected.to redirect_to(user_path(user))
          end
          it 'レコードの値が更新されること' do
            subject
            user.reload
            expect(user.username).to eq 'username'
          end
          it 'MxProfileレコードが1増えること' do
            expect{ subject }.to change(MxProfile, :count).by(1)
          end
        end

        context 'MxProfileにデータがある場合' do
          let(:mx_profile) { FactoryBot.create(:mx_profile, user_id: user.id) }
          let(:params) do
            { user:
              { username: 'username',
                avatar: 'hoge',
                mx_profile_attributes: {
                  id: mx_profile.id,
                  mx_history_id: 2,
                  license_id: 3
                }
              }
            }
          end
          before { patch :update, params: { id: user.id }.merge(params) }
          it 'MxProfileレコードが更新されること' do
            mx_profile.reload
            expect(mx_profile.mx_history_id).to eq 2
            expect(mx_profile.license_id).to eq 3
          end
        end
      end
    end

    context 'リクエストされたデータが存在しない場合' do
      before { patch :update, params: { id: user.id + 1 }.merge(params) }
      it 'リダイレクトされること' do
        expect(response).to redirect_to user_path(user)
      end
    end
  end
end
