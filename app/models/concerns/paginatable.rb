# frozen_string_literal: true

module Paginatable
  extend ActiveSupport::Concern

  class_methods do
    # Paginates a collection (Array or ActiveRecord relation) and returns the current page items
    # along with the next page number if more items exist.
    #
    # @param collection [Array, ActiveRecord::Relation] the collection to paginate
    # @param page_limit [Integer] number of items per page (default: 20)
    # @param page [Integer, nil] current page number (default: 0 or params[:page] if available)
    # @return [Array] two-element array: [items for the current page, next_page number or nil]
    def paginate_with_next_page(collection, page_limit: 20, page: nil)
      current_page = page || (defined?(params) ? params[:page].to_i : 0)
      total_count = collection.respond_to?(:count) ? collection.count : collection.size

      # Fetch items for the current page
      items = if collection.respond_to?(:offset) && collection.respond_to?(:limit)
        collection.offset(page_limit * current_page).limit(page_limit)
      else
        collection.slice(page_limit * current_page, page_limit) || []
      end

      # Calculate next page number if more items exist
      next_page = (total_count > page_limit * (current_page + 1)) ? current_page + 1 : nil

      [ items, next_page ]
    end
  end
end
