class UsersController < ApplicationController

  def index
    @users = User.with_attached_avatar
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    # user = User.create
    # image_match = params[:avatar].match(/^data:(.*?);(?:.*?),(.*)$/)
    # mime_type, encoded_image = image_match.captures
    # extension = mime_type.split('/').second
    # decoded_image = Base64.decode64(encoded_image)
    # filename = "avater#{user.id}.#{extension}"
    # image_path = "#{Rails.root}/tmp/storage/#{filename}"
    # File.open(image_path, 'wb') do |f|
    #   f.write(decoded_image)
    # end
    # user.avatar.attach({ io: File.open(image_path), filename: filename, content_type: mime_type })


    @user = User.new(user_params)

    if @user.save
      # user = User.create
      image_match = params[:avatar].match(/^data:(.*?);(?:.*?),(.*)$/)
      mime_type, encoded_image = image_match.captures
      extension = mime_type.split('/').second
      decoded_image = Base64.decode64(encoded_image)
      filename = "avater#{@user.id}.#{extension}"
      image_path = "#{Rails.root}/tmp/storage/#{filename}"
      File.open(image_path, 'wb') do |f|
        f.write(decoded_image)
      end
      @user.avatar.attach({ io: File.open(image_path), filename: filename, content_type: mime_type })
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:content, :point_id ,:avatar)
  end
end
