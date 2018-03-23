require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { described_class.new(name: 'Andrew Oliver', password: 'liber2018', email: 'andrew@test.com') }

  it 'When user filled the form correctely' do
    expect(subject).to be_valid
  end

  it 'when name blank' do
    subject.update(name: nil)
    expect(subject).to_not be_valid
  end

  it 'when email blank' do
    subject.update(email: nil)
    expect(subject).to_not be_valid
  end

  it 'when password blank' do
    subject.update(password: nil)
    expect(subject).to_not be_valid
  end

  it "when password can't have less then 6 characters" do
    subject.password = '12345'
    expect(subject).to_not be_valid
  end

  it 'when emails is invalid' do
    subject.update(email: 'bla bla')
    expect(subject).to_not be_valid
  end
end
