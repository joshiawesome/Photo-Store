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

  # elastic search setting configuration
  # settings is a regular method
  settings (
    { 
      index: {
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
    }
  )
  # elastic search mapping configuration
  # mapping is DSL (Domain Specific Language) of Elasticsearch for defining the structure of the index
  # here we pass a block to the method 'mapping'
  # block is taken and is internally converted to a hash and used to define the mapping
  # DSL is like instructions:
  #
  # example: 
  # Recipe DSL:
  #   add flour
  #   add sugar
  #   bake for 30 minutes
  mapping do
      indexes :name,
              type: "text",
              analyzer: "autocomplete",
              search_analyzer: "search_analyzer"
  end

  # custom method for the model to search products by name
  def self.search_by_name(query)
      if query.blank?
        __elasticsearch__.search({ query: { match_all: {} } })
      else
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
end
