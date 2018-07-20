class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    @resp = Faraday.post 'https://github.com/login/oauth/access_token' do |req|
      req.headers['Accept'] = 'application/json'
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['code'] = params['code']
    end
    parsed_json = JSON.parse(@resp.body)
    session[:token] = parsed_json['access_token']
    redirect_to root_path
  end
end