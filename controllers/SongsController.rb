class SongsController < ApplicationController

	get '/' do
		@songs = Songs.order("lower(artist) ASC").all
		erb :'songs/songs', :locals => {:songs => @songs}
	end

	get '/new' do 
		erb :'songs/song_new'
	end

	get '/edit/:id' do
		@song = Songs.find(params[:id])
		erb :'songs/song_edit', :locals => {:song => @song}
	end

	get '/:id' do
		@song = Songs.find(params[:id])
		erb :'songs/song_single', :locals => {:song => @song}
	end

	get '/delete/:id' do
		@song = Songs.find(params[:id])
		if @song.destroy
			redirect '/songs'
		else
			redirect back
		end
	end

	get '/like/:id' do
		like(params[:id])
	end

	post '/new' do
		create(params)
	end

	post '/edit' do
		edit(params[:song_id])
	end

	def create(params)
		@song = Songs.new
		@song.title = params[:song_title]
		@song.artist = params[:song_artist]
		@song.album = params[:song_album]
		@song.release_year = params[:song_release_year]
		@song.likes = 0
		@song.spotify_url = params[:song_spotify_url]
		if @song.save
			redirect '/songs/' + @song.id.to_s
		else
			redirect back
		end
	end

	def edit(id)
		@song = Songs.find(id)
		@song.title = params[:song_title]
		@song.artist = params[:song_artist]
		@song.album = params[:song_album]
		@song.release_year = params[:song_release_year]
		@song.likes = params[:song_likes]
		@song.spotify_url = params[:song_spotify_url]
		if @song.save
			redirect '/songs/' + @song.id.to_s
		else
			redirect back
		end
	end

	def like(id)
		@song = Songs.find(id)
		@song.likes = @song.likes + 1
		if @song.save
			redirect back
		else
			redirect back
		end
	end

end
