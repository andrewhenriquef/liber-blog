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

def params
  {
    body: 'some whatever content',
    user: User.first,
    post: Post.first

  }
end

RSpec.describe Comment, type: :model do
  subject(:comment) { described_class.new(params) }

  it 'User filled correctely' do
    expect(subject).to be_valid
  end
  
  it "body can't be blank" do
    subject.update(body: nil)
    expect(subject).to_not be_valid
  end

  it "body can't exceed 250 characteres" do
    subject.update(body: text_lorem)
    expect(subject).to_not be_valid
  end

  it "can't create without post" do
    subject.update(post: nil)
    expect(subject).to_not be_valid
  end

  it "can't create without user" do
    subject.update(user: nil)
    expect(subject).to_not be_valid
  end
end
