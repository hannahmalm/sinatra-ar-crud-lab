
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end


  #read CRUD action responds to two different controllers - show and index
  #show renders to show.erb view - shows an individual article 
  #Index action renders ErB view in index erb which shows all list of all articles
  #get '/articles' controller grabs all articles and stores in instance variable - renders in index.erb
  get "/articles" do 
    @articles = Article.all 
    erb :index
  end 
  #create - create a route in controller get '/articles/new' - renders to new.erb view
  get "/articles/new" do 
    @article = Article.new
    erb :new 
  end 
  #tell the controller what to do when your form sends that post request, create a route on controller
  post "/articles" do 
    @article = Article.create(params)
    redirect to "/articles/#{ @article.id }"
  end 
  #get '/articles/:id should use Active Record to grab the article with id that is in the params' - renders in show.erb
  get '/articles/:id' do 
      @article = Article.find(params[:id])
      erb :show 
  end 

  #edit the current article by finding the id - the first step to editing is finding using a get
  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end 

  #update the article - you need to use a patch to update something instead of a get
  patch "/articles/:id" do 
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end 

  #delete a record - use a delete  - need to have id to find the record to delete
  #Dynamically set the :id of the form action to refelect the id of the article you're editing
  #form needds a hidden input to change the request from POST to DELETE
  delete "/articles/:id" do 
      Article.destroy(params[:id])
      redirect to "/articles"
  end 


end

#the way you define the routes is important
#would need to define /articles/new route before /artiles/:id
