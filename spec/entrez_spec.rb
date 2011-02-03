require 'spec_helper'

describe Entrez do

  it 'should have default params for tool and email' do
    Entrez.default_params[:tool].should eq('ruby')
    Entrez.default_params[:email].should_not be_nil
  end

  it 'should efetch results' do
    rs_number = 9268480.to_s
    Entrez.efetch('snp', {id: rs_number, retmode: 'xml'}).should eq(file_fixture('efetch.xml'))
  end

end
