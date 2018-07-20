class RepositoriesController < ApplicationController

  def index
    @resp = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = session[:token]
      req.params['affiliation'] = 'owner'
      req.params['sort'] = 'updated'
    end
    parsed_json = JSON.parse(@resp.body)
    if @resp.success?
      @repos = parsed_json
    else
      @error = "Something went wrong."
    end
  end

  def create
    Faraday.post 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = JSON.generate({name: params[:name]})
      req.body = JSON.generate({private: false})
      req.body = JSON.generate({auto_init: true})
    end
    redirect_to root_path
  end

end
