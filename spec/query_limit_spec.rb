require 'spec_helper'

describe 'Entrez#respect_query_limit' do

  it 'should not perform more than 3 queries per second' do
    fake_service :ESearch, 'esearch_empty.xml', ignore_query_limit: false do
      requests = proc { 4.times { Entrez.ESearch('asdf') } }
      requests.should take_longer_than(1.0)
    end
  end

  it 'can be disabled for testing such as when FakeWeb is used' do
    Entrez.ignore_query_limit do
      fake_service :ESearch, 'esearch_empty.xml' do
        requests = proc { 4.times { Entrez.ESearch('asdf') } }
        requests.should_not take_longer_than(1.0)
      end
    end
  end

end
