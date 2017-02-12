require 'rails_helper'

describe Page do
  it 'can round-trip spaces' do
    s1 = Space.new \
      uid:              '123',
      name:             'asdf',
      description:      'zxcv qwer',
      proof_of_topology: nil
    p1 = Page::SpacePage.new s1

    s2 = Page::SpacePage.parse p1.path, p1.contents
    expect(s1).to eq s2

    p2 = Page::SpacePage.new s2
    expect(p1.contents).to eq p2.contents
  end
end
