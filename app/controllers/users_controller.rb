class UsersController < ApplicationController
  def index
    @pages, @users = paginate(active_record: User.order(:id),
                              previous_and_next_page_count: 3,
                              max_item_count: 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: t('users.flash.messages.created')
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])

    user.destroy
    redirect_to root_path, notice: t('users.flash.messages.deleted', name: user.name)
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:name, :email, :gender, :birthday, :password, :password_confirmation)
  end
end
