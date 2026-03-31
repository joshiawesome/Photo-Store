# This is a Rake task
# Rake is a task-runner for Ruby
# It is like npm scripts/CLI automation tools but for Ruby
namespace :es do
  desc "Rebuild Elasticsearch index for Product"
  # environment means run the full Rails application before running this task
  task rebuild_products: :environment do
    puts "Deleting and recreating index..."

    Product.__elasticsearch__.create_index!(force: true)

    puts "Importing data..."

    Product.import

    puts "Done 🎉"
  end
end

# Database (Postgres) -> Product.import -> Elasticsearch Index
#                                        ↓
#                                  Product.search("iphone")
