module PaginationHelper
  MAX_ITEM_COUNT = 20

  def paginate(collection, max_item_count: MAX_ITEM_COUNT)
    [
      pages(collection, max_item_count),
      collection_per_page(collection, max_item_count)
    ]
  end

  def pages(collection, max_item_count)
    {
      current_page: current_page,
      last_page: last_page(collection, max_item_count)
    }
  end

  def current_page
    params[:page]&.to_i || 1
  end

  def last_page(collection, max_item_count)
    (collection.count.to_f / max_item_count).ceil
  end

  def collection_per_page(collection, max_item_count)
    collection.limit(max_item_count).offset((current_page - 1) * max_item_count)
  end
end
