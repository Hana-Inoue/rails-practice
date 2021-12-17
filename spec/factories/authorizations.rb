FactoryBot.define do
  factory :authorization do
    controller { UsersController.name.delete_suffix('Controller').underscore }
    action { UsersController.instance_methods(false).first }
  end
end
