module CreateAuthorizationsSupport
  def create_authorizations
    [
      UsersController,
      UserAddressesController,
      UserDiariesController,
      UserPostsController,
      UserPostCommentsController,
      EventsController,
      TodosController,
      SchedulesController,
      ShopsController,
      ProductsController,
      CartsController,
      AuthorizationsController,
      StaticPagesController
    ] .each do |controller|
        controller.instance_methods(false).map(&:to_s).each do |action|
          Authorization
            .create!(controller: controller.name.delete_suffix('Controller').underscore,
                     action: action)
        end
    end
  end
end

RSpec.configure do |config|
  config.include CreateAuthorizationsSupport
end
