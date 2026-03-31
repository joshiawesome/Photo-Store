class Product < ApplicationRecord
  # Adding Elasticsearch capabilities to the Product model
  # Make this Rails model searchable via Elasticsearch.”
  include Elasticsearch::Model
  # It hooks into ActiveRecord lifecycle callbacks and automatically syncs data with Elasticsearch.
  # For example, when a Product is created, updated, or deleted, it will be automatically synced with Elasticsearch.
  include Elasticsearch::Model::Callbacks

  self.primary_key = "id"
  
  has_many :variants
  has_many :images, as: :imageable
  has_many :additional_informations

  # settings is a method to which index configuration is passed
  settings index: {
    analysis: {
      tokenizer: {
        autocomplete_tokenizer: {
          type: "edge_ngram",
          min_gram: 1,
          max_gram: 20,
          token_chars: ["letter", "digit"]
        }
      },
      analyzer: {
        autocomplete: {
          type: "custom",
          tokenizer: "autocomplete_tokenizer",
          filter: ["lowercase"]
        },
        search_analyzer: {
          type: "custom",
          tokenizer: "standard",
          filter: ["lowercase"]
        }
      }
    }
}
# mapping is a method to which mapping configuration is passed
mapping do
    indexes :name,
            type: "text",
            analyzer: "autocomplete",
            search_analyzer: "search_analyzer"
end

def self.search_by_name(query)
  __elasticsearch__.search(
    {
      query: {
        match: {
          name: {
            query: query,
            operator: "and"
          }
        }
      }
    }
  )
end
end
