class TodosController < ApplicationController
  def index
    @pages, @todos = paginate(active_record: Todo.order(:id),
                              previous_and_next_page_count: 2,
                              max_item_count: 20)
  end
end
