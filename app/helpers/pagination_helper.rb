module PaginationHelper
  PREVIOUS_AND_NEXT_PAGE_COUNT = 1
  MAX_ITEM_COUNT = 20
  FIRST_PAGE = 1

  def paginate(collection:,
               previous_and_next_page_count: PREVIOUS_AND_NEXT_PAGE_COUNT,
               max_item_count: MAX_ITEM_COUNT)
    [
      pages(collection, previous_and_next_page_count, max_item_count),
      collection_per_page(collection, max_item_count)
    ]
  end

  def pages(collection, previous_and_next_page_count, max_item_count)
    {
      current_page: current_page,
      last_page: last_page(collection, max_item_count),
      previous_and_next_page_count: previous_and_next_page_count
    }
  end

  def current_page
    params[:page]&.to_i || FIRST_PAGE
  end

  def last_page(collection, max_item_count)
    collection.count.zero? ? FIRST_PAGE : (collection.count.to_f / max_item_count).ceil
  end

  def collection_per_page(collection, max_item_count)
    collection.limit(max_item_count).offset((current_page - 1) * max_item_count)
  end
end
