module CreateControllerActionsSupport
  def create_controller_actions
    [UsersController, ControllerActionsController, StaticPagesController].each do |controller|
      controller.instance_methods(false).map(&:to_s).each do |action|
        ControllerAction.create!(controller: controller.name, action: action)
      end
    end
  end
end

RSpec.configure do |config|
  config.include CreateControllerActionsSupport
end
