require 'gossip'
class ApplicationController < Sinatra::Base
  
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  
  get '/gossips/new' do
		erb :new_gossip
  end

  post '/gossips/new' do
	  Gossip.new(params["gossip_author"], params["gossip_content"]).save
	  redirect '/'
	end

  get '/gossips/:id' do
		erb :show, locals: {show: Gossip.all[params[:id].to_i], id: params[:id].to_i}
  end

  get '/gossips/delete/:id' do
    arr_of_arrs = CSV.read("db/gossip.csv")
    arr_of_arrs.delete_at(params[:id].to_i)

    CSV.open("./db/gossip.csv", "wb") do |csv|
        arr_of_arrs.each do |x, y|
            csv << [x, y]
        end
    end
    redirect '/'
  end
  
end
