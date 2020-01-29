# frozen_string_literal: true

require 'rails_helper'

describe Like, type: :model do
  let(:like) { create(:like) }

  it { should belong_to(:user) }
  it { should belong_to(:post) }
end
