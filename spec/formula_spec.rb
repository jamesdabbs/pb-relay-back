require 'rails_helper'

F = Formula[T::String, T::Bool]

describe 'Formula' do
  let(:f) {
    F.and(
      F.atom("foo", true),
      F.atom("bar", false),
      F.or(
        F.atom("baz", false),
        F.atom("quux", true)
      )
    )
  }

  it 'can convert to YAML' do
    expect(F.to_yaml f).to eq({
      'and' => [
        { 'foo' => true },
        { 'bar' => false },
        {
          'or' => [
            { 'baz'  => false },
            { 'quux' => true }
          ]
        }
      ]
    })
  end

  it 'can map' do
    expect(f.map { |p| p.reverse }.and.first.property).to eq 'oof'
  end
end
