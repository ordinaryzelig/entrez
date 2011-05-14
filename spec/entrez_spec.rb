require 'spec_helper'

describe Entrez do

  it 'should have default params for tool and email' do
    Entrez.default_params[:tool].should eq('ruby')
    Entrez.default_params[:email].should_not be_nil
  end

  it '#EFetch retrieves results' do
    response = Entrez.EFetch('snp', {id: 9268480})
    response.code.should == 200
  end

  it '#ESummary retrieves results' do
    response = Entrez.ESummary('genomeprj', {id: 62343})
    response.code.should == 200
  end

  it 'should respect query limit' do
    requests = proc { 4.times { Entrez.EFetch('snp', id: 9268480) } }
    requests.should take_longer_than(1.0)
  end

end
