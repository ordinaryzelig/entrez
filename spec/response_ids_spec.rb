require 'spec_helper'

describe HTTParty::ResponseIds do

  it 'parses body and returns IDs' do
    fake_service :ESearch, 'esearch_1_2_3.xml' do
      response = Entrez.ESearch('asdf')
      response.ids.should == [1, 2, 3]
    end
  end

  it 'returns empty array if nothing found' do
    fake_service :ESearch, 'esearch_empty.xml' do
      response = Entrez.ESearch('asdf')
      response.ids.should be_empty
    end
  end

  it 'returns array even if only 1 id found' do
    fake_service :ESearch, 'esearch_1.xml' do
      response = Entrez.ESearch('asdf')
      response.ids.should == [1]
    end
  end

end
