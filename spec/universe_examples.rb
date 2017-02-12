RSpec.shared_examples 'universe' do
  it 'can fetch spaces' do
    spaces = subject.all_spaces
    expect(spaces.count).to be > 140
    expect(spaces.first.name).to include 'Omega'
    expect(spaces.first.description).to include 'first uncountable ordinal'
  end

  it 'can fetch properties' do
    props = subject.all_properties
    expect(props.count).to be > 70
    expect(props.first.name).to eq '2-Markov-Winning Menger'
  end

  it 'can fetch all theorems' do
    theorems = subject.all_theorems
    expect(theorems.count).to be > 160
    expect(theorems.first.antecedent.property.name).to eq 'Compact'
  end

  it 'can fetch all traits' do
    traits = subject.all_traits
    expect(traits.count).to be > 8000
    expect(traits.first.space.name).to eq 'Finite Discrete Topology'
    expect(traits.first.property.name).to eq 'Compact'
  end

  it 'can find traits for a space' do
    space  = subject.all_spaces.first
    traits = subject.space_traits space
    expect(traits.map { |t| t.property.uid }.uniq.count).to be > 70
    expect(traits.map { |t| t.space.uid    }.uniq.count).to eq 1
  end

  it 'can find one trait' do
    space  = subject.all_spaces.first
    traits = subject.space_traits space, property_name: 'Compact'
    expect(traits.count).to eq 1
    expect(traits.first.property.name).to eq 'Compact'
  end

  it 'can fetch a theorem by id' do
    t1 = subject.all_theorems.sample
    t2 = subject.theorems_by_ids [t1.uid]
    expect(t2).to eq [t1]
  end

  it 'can fetch a trait by id' do
    t1 = subject.all_traits.sample
    id = subject.lookup_trait t1
    t2 = subject.traits_by_ids [id]
    expect(t2).to eq [t1]
  end

  it 'can pull proof data'
end
