class SongController < Sinatra::Base

    configure do
        set :views, 'app/views/songs'
    end

    get '/songs' do 
        @songs = Song.all
        erb :index
    end

    get '/songs/new' do 
        erb :new
    end

    post '/songs' do 
        @artist = Artist.find_or_create_by(name: params[:artist])
        @song = Song.new(name: params[:name], artist: @artist)

        if @song.save
            params[:genres].each do |g_id|
                SongGenre.create(song_id: @song.id, genre_id: g_id)
            end
            flash[:message] = "Successfully created song."
            redirect "/songs/#{Slug.slugify(@song.name)}"
        else 
            @errors = @song.errors.full_messages 
            @songs = Song.all 
            erb :new
        end
    end
        

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :show
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :edit
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @artist = Artist.find_or_create_by(name: params[:Song][:artist])
        @song.update(name: params[:Song][:name], artist: @artist)
        @song.song_genres.each { |sg| sg.destroy }
        @song.reload
        params[:genres].each do |g_id|
            SongGenre.create(song_id: @song.id, genre_id: g_id)
        end

        redirect "/songs/#{Slug.slugify(@song.name)}"
    end
end