require 'rails_helper'

def text_lorem
  'Lorem ipsum fringilla magna aliquet est euismod faucibus interdum maecenas
  justo condimentum tempor turpis curabitur, aenean velit porta amet aliquam tristique
  phasellus viverra litora nostra ante orci ac. iaculis sodales in commodo ac mollis
  purus mollis, class eu praesent dapibus molestie euismod_not fames, hac placerat semper
  dolor aenean vel. interdum feugiat cubilia quisque rutrum volutpat fusce hendrerit
  vulputate ultricies et, mattis molestie tempor ligula sodales sagittis netus ac
  imperdiet ante purus, porttitor placerat fusce ullamcorper accumsan netus cubilia
  donec facilisis. fusce placerat eros pulvinar sollicitudin cras nec, risus mattis
  mauris urna mauris mi torquent, vestibulum taciti egestas justo mauris.'
end

RSpec.describe Post, type: :model do
  subject(:post) { described_class.new(title: 'ok', description: 'mai ok ainda', user: User.first) }

  it 'Filled correctely' do
    expect(subject).to be_valid
  end

  it 'title blank' do
    subject.update(title: nil)
    expect(subject).to_not be_valid
  end

  it 'description blank' do
    subject.update(description: nil)
    expect(subject).to_not be_valid
  end

  it 'user blank' do
    subject.update(user: nil)
    expect(subject).to_not be_valid
  end

  it 'title exceed maximum length' do
    subject.update(title: text_lorem)
    expect(subject).to_not be_valid
  end

  it 'description exceed maximum length' do
    subject.update(description: text_lorem)
    expect(subject).to_not be_valid
  end
end
