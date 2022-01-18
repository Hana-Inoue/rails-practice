class TodosController < ApplicationController
  def index
    @todos_search_params = todos_search_params
    @pages, @todos = paginate(active_record: Todo.order(:id),
                              previous_and_next_page_count: 2,
                              max_item_count: 20)
  end

  def search
    @todos_search_params = todos_search_params
    @pages, @todos = paginate(active_record: Todo.search(@todos_search_params).order(:id))

    render :index
  end

  private

  def todos_search_params
    params
      .fetch(:search, {})
      .permit(:due_date, :completed_date)
  end
end
