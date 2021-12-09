module CreateControllerActionsSupport
  def create_controller_actions
    UsersController.instance_methods(false).map(&:to_s).each do |action|
      ControllerAction.create!(controller: UsersController.name, action: action)
    end
    ControllerActionsController.instance_methods(false).map(&:to_s).each do |action|
      ControllerAction.create!(controller: ControllerActionsController.name, action: action)
    end
    StaticPagesController.instance_methods(false).map(&:to_s).each do |action|
      ControllerAction.create!(controller: StaticPagesController.name, action: action)
    end
  end
end

RSpec.configure do |config|
  config.include CreateControllerActionsSupport
end
