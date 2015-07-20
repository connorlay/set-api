require 'rails_helper'

RSpec.describe Membership, type: :model do

  subject { create :membership }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :game }

  it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:game_id) }

  it { is_expected.to have_db_index :user_id }
  it { is_expected.to have_db_index :game_id }
  it { is_expected.to have_db_index [ :user_id, :game_id ] }

end
