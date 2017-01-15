describe TopologySchema do
  it 'can look up spaces' do
    query = %|{
      space(id: 1) {
        name
        description
        traits(first: 3) {
          edges {
            node {
              id
              value
              property {
                name
              }
            }
          }
        }
      }
    }|
    result = subject.execute query
    expect(result["errors"]).to eq nil
  end

  it 'can look up properties' do
    query = %|{
      property(id: 1) {
        name
        description
        traits(first: 3) {
          edges {
            node {
              id
              value
              space {
                name
              }
            }
          }
        }
      }
    }|
    result = subject.execute query
    expect(result["errors"]).to eq nil
  end
end
