Before('@omniauth_test') do
	OmniAuth.config.test_mode = true

	OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
		"provider"=>"twitter",
		"uid"=>"12345"
		})
end

After('@omniauth_test') do
	OmniAuth.config.test_mode = false
end
