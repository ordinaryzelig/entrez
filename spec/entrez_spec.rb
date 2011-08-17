require 'spec_helper'

describe Entrez do

  it 'should have default params for tool and email' do
    Entrez.default_params[:tool].should eq('ruby')
    Entrez.default_params[:email].should_not be_nil
  end

  it '#EFetch retrieves results' do
    response = Entrez.EFetch('taxonomy', id: 9606)
    response.body.should include('Homo sapiens')
  end

  it '#ESummary retrieves results' do
    response = Entrez.ESummary('genomeprj', id: 28911)
    response.body.should include('Hapmap')
  end

  it '#EInfo retrieves results' do
    response = Entrez.EInfo('snp')
    response.body.should include('<Name>RS</Name>')
  end

  context '#ESearch' do

    it 'retrieves results' do
      response = Entrez.ESearch('genomeprj', {WORD: 'hapmap', SEQS: 'inprogress'})
      response.body.should include('28911')
    end

    it 'accepts string as search_terms parameter' do
      response = Entrez.ESearch('genomeprj', 'hapmap[WORD]')
      response.ids.should include(60153)
    end

    it 'handles array of uids' do
      response = Entrez.ESearch('gene', {UID: [1, 2, 3]})
      response.ids.should =~ [1, 2, 3]
    end

  end

  it 'should convert search term hash into query string with AND operator by default' do
    query_string = {TITL: 'BRCA1', ORGN: 'human'}
    Entrez.convert_search_term_hash(query_string).should == 'BRCA1[TITL]+AND+human[ORGN]'
  end

  it 'should convert search term hash into query string with OR operator with parentheses' do
    query_string = {TITL: 'BRCA1', ORGN: 'human'}
    Entrez.convert_search_term_hash(query_string, 'OR').should == '(BRCA1[TITL]+OR+human[ORGN])'
  end

end
