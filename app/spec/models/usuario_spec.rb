# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Usuario, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:papel) } # Add validation for 'papel'
  end

  describe 'Authentication' do
    # Use the :aluno trait to set the 'papel' attribute
    let!(:user) { create(:usuario, :aluno, email: 'test@example.com', password: 'password123') }

    it 'authenticates with valid credentials' do
      expect(user.valid_password?('password123')).to be true
    end

    it 'does not authenticate with invalid password' do
      expect(user.valid_password?('wrongpass')).to be false
    end
  end
end
