# frozen_string_literal: true

require 'rails_helper'

describe Comment, type: :model do
  let(:comment) { create(:comment) }

  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:text) }
end
