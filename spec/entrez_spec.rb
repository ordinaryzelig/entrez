require 'spec_helper'

describe Entrez do

  it 'should have default params for tool and email' do
    Entrez.default_params[:tool].should eq('ruby')
    Entrez.default_params[:email].should_not be_nil
  end

  it 'should efetch results' do
    Entrez.efetch('snp', {id: 9268480, retmode: 'xml'}).should eq(file_fixture('efetch.xml'))
  end

  it 'should respect query limit' do
    requests = proc { 4.times { Entrez.efetch('snp', id: 9268480) } }
    requests.should take_longer_than(1.0)
  end

end
