require 'spec_helper'

describe QueryStringNormalizer do

  it 'does not escape' do
    query = {term: '[asdf]', db: 'snp'}
    QueryStringNormalizer.call(query).should == 'term=[asdf]&db=snp'
  end

end
