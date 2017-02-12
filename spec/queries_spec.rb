require 'rails_helper'

require 'universe_examples'

describe 'Queries' do
  context DB do
    subject { DB::Queries.new }

    include_examples 'universe'
  end

  context Git do
    subject { Git::Queries.new Rails.root.join('db', 'git', 'test') }

    include_examples 'universe'
  end
end
