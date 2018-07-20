class RepositoriesController < ApplicationController

  def index
    @user_resp = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repo_resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    parsed_repos = JSON.parse(@resp.body)
    if @repo_resp.success? && @user_resp
      @repos = parsed_json
    else
      @error = "Something went wrong."
    end
  end

  def create
    Faraday.post 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {"name": params[:name]}
    end
    redirect_to root_path
  end

end
