module CreateControllerActionsSupport
  def create_controller_actions
    ['index', 'show', 'new', 'edit', 'create', 'update', 'destroy'].each do |action|
      ControllerAction.create!(controller: 'users', action: action)
    end
    ['about_server_logs', 'about_activerecord_logs'].each do |action|
      ControllerAction.create!(controller: 'static_pages', action: action)
    end
  end
end

RSpec.configure do |config|
  config.include CreateControllerActionsSupport
end
