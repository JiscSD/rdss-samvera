 # Generated via
#  `rails generate hyrax:work Article`
class ArticleIndexer < Hyrax::WorkIndexer
  # This indexes the default metadata. You can remove it if you want to
  # provide your own metadata and indexing.
  include Hyrax::IndexesBasicMetadata

  # Fetch remote labels for based_near. You can remove this if you don't want
  # this behavior
  include Hyrax::IndexesLinkedMetadata

  # Custom indexing behavior
  def generate_solr_document
    super.tap do |solr_doc|
      # date
      solr_doc[Solrizer.solr_name('date', :stored_searchable)] = object.date.map { |d| d.date.first }
      solr_doc[Solrizer.solr_name('date', :displayable)] = object.date.to_json
      object.date.each do |d|
        label = DateTypesService.label(d.description.first) rescue nil
        if label
          solr_doc[Solrizer.solr_name("date_#{label.downcase}", :stored_sortable)] = d.date
        end
      end
      # creator
      creators = object.creator_nested.map { |c| (c.first_name + c.last_name).reject(&:blank?).join(' ') }
      solr_doc[Solrizer.solr_name('creator_nested', :facetable)] = creators
      solr_doc[Solrizer.solr_name('creator_nested', :stored_searchable)] = creators
      solr_doc[Solrizer.solr_name('creator_nested', :displayable)] = object.creator_nested.to_json
      # rights
      solr_doc[Solrizer.solr_name('rights_nested', :stored_searchable)] = object.rights_nested.map { |r| r.webpage.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('rights_nested', :facetable)] = object.rights_nested.map { |r| r.webpage.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('rights_nested', :displayable)] = object.rights_nested.to_json
      # subject
      solr_doc[Solrizer.solr_name('subject_nested', :stored_searchable)] = object.subject_nested.map { |s| s.label.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('subject_nested', :facetable)] = object.subject_nested.map { |s| s.label.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('subject_nested', :displayable)] = object.subject_nested.to_json
      # relation
      solr_doc[Solrizer.solr_name('relation_url', :facetable)] = object.relation.map { |r| r.url.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('relation_id', :facetable)] = object.relation.map { |r| r.identifier.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('relation', :displayable)] = object.relation.to_json
      # admin metadata
      solr_doc[Solrizer.solr_name('admin_metadata', :displayable)] = object.admin_metadata.to_json
      # project
      solr_doc[Solrizer.solr_name('project_id', :stored_searchable)] = object.project.map { |p| p.identifier.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('project', :stored_searchable)] = object.project.map { |p| p.title.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('funder', :stored_searchable)] = object.project.map { |p| p.funder_name.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('funder', :facetable)] = object.project.map { |p| p.funder_name.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('funder_id', :facetable)] = object.project.map { |p| p.funder_id.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('grant_number', :stored_searchable)] = object.project.map { |p| p.grant_number.first }.reject(&:blank?)
      solr_doc[Solrizer.solr_name('project', :displayable)] = object.project.to_json
    end
  end
end
