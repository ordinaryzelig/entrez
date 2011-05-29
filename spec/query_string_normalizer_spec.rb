require 'spec_helper'

describe QueryStringNormalizer do

  it 'does not escape square brackets' do
    query = {term: '[asdf]', db: 'snp'}
    QueryStringNormalizer.call(query).should == 'term=[asdf]&db=snp'
  end

  it 'escapes spaces' do
    query = {term: 'a b c'}
    QueryStringNormalizer.call(query).should == 'term=a%20b%20c'
  end

end
