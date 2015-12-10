json.array!(@profiles) do |profile|
  json.extract! profile, :id, :user_id, :home_address, :description
  json.url profile_url(profile, format: :json)
end
