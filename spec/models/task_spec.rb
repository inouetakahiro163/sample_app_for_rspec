require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      task = build(:task)
      expect(task).to be_valid
      expect(task.errors).to be_empty
    end

    it 'is invalid without title' do 
      task = build(:task, title: nil)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without status' do 
      task = build(:task, status: nil)
      expect(task).to_not be_valid
    end

    it 'is invalid with a duplicate title' do
      task = create(:task)
      task = build(:task)
      task.valid?
      expect(task.errors[:title]).to include("has already been taken")
    end

    it 'is valid with a another title' do
      task = create(:task)
      task = build(:task, title: "anotherone")
      expect(task).to be_valid
    end
  end
end
