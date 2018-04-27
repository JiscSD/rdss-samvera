require 'spec_helper'

describe DoiNormaliser do
  let(:valid_dois) {
    [
    '10.1007/s10067-013-2203-9',
    'doi:10.1007/s10067-013-2203-9',
    'doi: 10.3389/fpsyg.2015.01242',
    '10.1080/17533015.2014.924974',
    '10.1177/0305735613483668',
    '10.3332/ecancer.2016.631',
    '10.1016/j.puhe.2015.12.005',
    ' 10.1159/000431257',
    '10.1177/1321103X14523531 ',
    '10.1111/j.1477-4658.2011.00787.x',
    '10.1093/em/cas155',
    '10.1371/journal.pone.0151136',
    '10.1177/0305735615577769',
    '10.1093/em/cau100',
    '10.3389/fpsyg.2016.01229',
    '10.1186/s13612-016-0048-0',
    '10.1016/j.puhe.2017.01.016',
    '10.1177/0305735617705720',
    '10.1108/S1479-363620150000007015',
    '10.1080/13598139.2016.1264293',
    '10.3389/fpsyg.2017.00513',
    '10.1111/papr.12581',
    '10.5694/mja16.01045',
    '10.1097/HNP.0000000000000135',
    ' https://doi.org/10.1177/0305735611401126',
    '10.1080/10413200.2011.574676',
    'http://doi.org/10.1007/s10067-013-2203-9',
    '10.1017/CBO9781107337404',
    'https://doi.org/10.1017/CBO9781107337404'
    ]
  }

  let(:parsed_valid_dois) {
    [
    '10.1007/s10067-013-2203-9',
    '10.1007/s10067-013-2203-9',
    '10.3389/fpsyg.2015.01242',
    '10.1080/17533015.2014.924974',
    '10.1177/0305735613483668',
    '10.3332/ecancer.2016.631',
    '10.1016/j.puhe.2015.12.005',
    '10.1159/000431257',
    '10.1177/1321103X14523531',
    '10.1111/j.1477-4658.2011.00787.x',
    '10.1093/em/cas155',
    '10.1371/journal.pone.0151136',
    '10.1177/0305735615577769',
    '10.1093/em/cau100',
    '10.3389/fpsyg.2016.01229',
    '10.1186/s13612-016-0048-0',
    '10.1016/j.puhe.2017.01.016',
    '10.1177/0305735617705720',
    '10.1108/S1479-363620150000007015',
    '10.1080/13598139.2016.1264293',
    '10.3389/fpsyg.2017.00513',
    '10.1111/papr.12581',
    '10.5694/mja16.01045',
    '10.1097/HNP.0000000000000135',
    '10.1177/0305735611401126',
    '10.1080/10413200.2011.574676',
    '10.1007/s10067-013-2203-9',
    '10.1017/CBO9781107337404',
    '10.1017/CBO9781107337404'
    ]
  }

  let(:url_valid_dois) {
    [
    'https://doi.org/10.1007/s10067-013-2203-9',
    'https://doi.org/10.1007/s10067-013-2203-9',
    'https://doi.org/10.3389/fpsyg.2015.01242',
    'https://doi.org/10.1080/17533015.2014.924974',
    'https://doi.org/10.1177/0305735613483668',
    'https://doi.org/10.3332/ecancer.2016.631',
    'https://doi.org/10.1016/j.puhe.2015.12.005',
    'https://doi.org/10.1159/000431257',
    'https://doi.org/10.1177/1321103X14523531',
    'https://doi.org/10.1111/j.1477-4658.2011.00787.x',
    'https://doi.org/10.1093/em/cas155',
    'https://doi.org/10.1371/journal.pone.0151136',
    'https://doi.org/10.1177/0305735615577769',
    'https://doi.org/10.1093/em/cau100',
    'https://doi.org/10.3389/fpsyg.2016.01229',
    'https://doi.org/10.1186/s13612-016-0048-0',
    'https://doi.org/10.1016/j.puhe.2017.01.016',
    'https://doi.org/10.1177/0305735617705720',
    'https://doi.org/10.1108/S1479-363620150000007015',
    'https://doi.org/10.1080/13598139.2016.1264293',
    'https://doi.org/10.3389/fpsyg.2017.00513',
    'https://doi.org/10.1111/papr.12581',
    'https://doi.org/10.5694/mja16.01045',
    'https://doi.org/10.1097/HNP.0000000000000135',
    'https://doi.org/10.1177/0305735611401126',
    'https://doi.org/10.1080/10413200.2011.574676',
    'https://doi.org/10.1007/s10067-013-2203-9',
    'https://doi.org/10.1017/CBO9781107337404',
    'https://doi.org/10.1017/CBO9781107337404'
    ]
  }

  let(:display_valid_dois) {
    [
    'doi: 10.1007/s10067-013-2203-9',
    'doi: 10.1007/s10067-013-2203-9',
    'doi: 10.3389/fpsyg.2015.01242',
    'doi: 10.1080/17533015.2014.924974',
    'doi: 10.1177/0305735613483668',
    'doi: 10.3332/ecancer.2016.631',
    'doi: 10.1016/j.puhe.2015.12.005',
    'doi: 10.1159/000431257',
    'doi: 10.1177/1321103X14523531',
    'doi: 10.1111/j.1477-4658.2011.00787.x',
    'doi: 10.1093/em/cas155',
    'doi: 10.1371/journal.pone.0151136',
    'doi: 10.1177/0305735615577769',
    'doi: 10.1093/em/cau100',
    'doi: 10.3389/fpsyg.2016.01229',
    'doi: 10.1186/s13612-016-0048-0',
    'doi: 10.1016/j.puhe.2017.01.016',
    'doi: 10.1177/0305735617705720',
    'doi: 10.1108/S1479-363620150000007015',
    'doi: 10.1080/13598139.2016.1264293',
    'doi: 10.3389/fpsyg.2017.00513',
    'doi: 10.1111/papr.12581',
    'doi: 10.5694/mja16.01045',
    'doi: 10.1097/HNP.0000000000000135',
    'doi: 10.1177/0305735611401126',
    'doi: 10.1080/10413200.2011.574676',
    'doi: 10.1007/s10067-013-2203-9',
    'doi: 10.1017/CBO9781107337404',
    'doi: 10.1017/CBO9781107337404'
    ]
  }


  let(:invalid_dois) {
    [
      '10.abcd/s10067-013-2203-9',
      'doi:10.abcd/s10067-013-2203-9',
      'iod:10.1007/s10067-013-2203-9',
      '10.1234/',
      '0921039032',
      'a test string'
    ]
  }

  it 'parses all valid dois' do
    valid_dois.zip(parsed_valid_dois).each do |doi, parsed_doi|
      expect(described_class.parse_doi(doi)).to eq(parsed_doi)
    end
  end

  it 'parsing is falsey for all invalid dois' do
    invalid_dois.each do |not_doi|
      expect(described_class.parse_doi(not_doi)).to be_falsey
    end
  end

  it 'renders url and display for all valid dois' do
    valid_dois.zip(url_valid_dois, display_valid_dois).each do |doi, url_doi, display_doi|
      expect(described_class.(doi)).to eq([url_doi, display_doi])
    end
  end


end