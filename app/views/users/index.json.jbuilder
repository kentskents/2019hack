if @users.present?
  json.users do
    json.array!(@users) do |user|
      json.extract! user, :id, :content, :point_id, :created_at
      json.image rails_blob_url(user.avatar) if user.avatar.attached?
    end
  end
end
