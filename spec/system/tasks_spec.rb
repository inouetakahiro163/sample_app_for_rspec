require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  include LoginSupport
  let(:user){ create(:user) }
  let(:task){ create(:task) }

  describe 'ログイン前' do
    describe 'タスクの新規作成' do
      context 'ログインしていない場合' do
        it 'タスクの新規作成ができない' do
          visit new_task_path
          expect(page).to have_content('Login required')
          expect(current_path).to eq login_path
        end
      end
    end

    describe 'タスクの編集' do
      context 'ログインしていない場合' do
        it 'タスクの編集ができない' do
          visit edit_task_path(task)
          expect(page).to have_content('Login required')
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before{ login_as(user) }
    describe 'タスクの新規作成' do
      context 'ログインした場合' do
        it 'タスクの新規作成ができる' do
          visit new_task_path
          fill_in 'Title', with: 'test'
          fill_in 'Content', with: 'test_content'
          select 'doing', from: 'Status'
          fill_in 'Deadline', with: DateTime.new(2020, 12, 31, 12, 30)
          click_button 'Create Task'
          expect(page).to have_content 'test'
          expect(page).to have_content 'test_content'
          expect(page).to have_content 'doing'
          expect(page).to have_content '2020/12/31 12:30'
          expect(current_path).to eq '/tasks/1'
        end
      end
    end

    describe 'タスクの編集' do
      let!(:task){ create(:task, user: user) }
      context 'ログインした場合' do
        it 'タスクの編集ができる' do
          visit 
        end
      end
    end

    describe 'タスクの削除' do
      context 'ログインした場合' do
        it 'タスクの削除ができる'
      end
    end
  end
end
