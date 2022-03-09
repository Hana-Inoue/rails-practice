module MenuItemsHelper
  def menu_items
    [
      { controller: 'users', action: 'index', path: "#{users_path}" },
      { controller: 'user_posts', action: 'index', path: user_posts_path },
      { controller: 'events', action: 'index', path: events_path },
      { controller: 'todos', action: 'index', path: todos_path },
      { controller: 'user_diaries',
        action: 'index',
        path: user_user_diaries_path(current_user.id) },
      { controller: 'schedules', action: 'index', path: schedules_path },
      { controller: 'shops', action: 'index', path: shops_path },
      { controller: 'products', action: 'index', path: products_path },
      { controller: 'static_pages',
        action: 'about_server_logs',
        path: static_pages_about_server_logs_path },
      { controller: 'static_pages',
        action: 'about_activerecord_logs',
        path: static_pages_about_activerecord_logs_path },
      { controller: 'static_pages',
        action: 'search_functions_summary',
        path: static_pages_search_functions_summary_path }
    ]
  end
end
