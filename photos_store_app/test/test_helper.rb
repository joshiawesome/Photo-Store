ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

unless Module.method_defined?(:stub)
  class Module
    def stub(method_name, return_value)
      singleton = singleton_class
      had_original = singleton.method_defined?(method_name) || singleton.private_method_defined?(method_name)
      original = singleton.instance_method(method_name) if had_original

      singleton.send(:define_method, method_name) { |_args = nil, **_kwargs, &_block| return_value }

      begin
        yield
      ensure
        if had_original
          singleton.send(:define_method, method_name, original)
        else
          singleton.send(:remove_method, method_name)
        end
      end
    end
  end
end
