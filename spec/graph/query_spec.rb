require 'rails_helper'

describe TopologySchema do
  it 'can look up spaces and traits' do
    result = subject.execute %|{
      viewer {
        spaces(name: "Finite Discrete Topology") {
          name
          description
          traits(propertyName: "$T_2$") {
            property {
              uid
              name
            }
            value
            description
          }
        }
      }
    }|

    expect(result["errors"]).to eq nil

    spaces = result["data"]["viewer"]["spaces"]
    expect(spaces.count).to eq 1

    space = spaces.first
    expect(space["description"]).to include "finite set"

    traits = space["traits"]
    expect(traits.count).to eq 1

    trait = traits.first
    expect(trait["value"]).to eq true

    prop = trait["property"]
    expect(prop["uid"]).to  eq "3"
    expect(prop["name"]).to eq "$T_2$"
  end

  it 'can fetch the trait table' do
    result = subject.execute %|{
      viewer {
        traitTable
      }
    }|

    expect(result["errors"]).to eq nil

    table = JSON.parse(result["data"]["viewer"]["traitTable"])
    expect(table.count).to eq 143
    expect(table["22"]["17"]).to eq({ "value" => false, "deduced" => false })
  end

  it 'can pull full proofs' do
    result = subject.execute %|{
      viewer {
        spaces(name: "Uncountable Discrete Topology") {
          traits(propertyName: "$T_0$") {
            proof(full: true)
          }
        }
      }
    }|

    expect(result["errors"]).to eq nil

    proof = JSON.parse \
      result["data"]["viewer"]["spaces"].first["traits"].first["proof"]

    expect(proof["theorems"].count).to eq 2
    expect(proof["traits"].count).to eq 1
    expect(proof["traits"].first["property"]["name"]).to eq "Discrete"
  end

  it 'can pull short proofs' do
    result = subject.execute %|{
      viewer {
        spaces(name: "Uncountable Discrete Topology") {
          traits(propertyName: "$T_0$") {
            proof
          }
        }
      }
    }|

    expect(result["errors"]).to eq nil

    proof = JSON.parse \
      result["data"]["viewer"]["spaces"].first["traits"].first["proof"]

    expect(proof["theorems"].count).to eq 1
    expect(proof["traits"].count).to eq 1
    expect(proof["traits"].first["property"]["name"]).to eq "$T_1$"
  end
end
