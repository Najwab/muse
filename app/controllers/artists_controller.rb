class ArtistsController < ApplicationController
  before_action :authenticate_user!,only: [:new, :show]

    def index 
        @artists = current_user.artists.all  
    end


    def show
        @artist = Artist.find(params[:id])
        @songs = @artist.songs

        if  @artist.user != current_user
          flash[:notice] = 'Not allowed!'
          redirect_to artists_path
        end 
   end

      def destroy
        Artist.find(params[:id]).destroy
      
        redirect_to artists_path
      end
      
      def new
        @artist = Artist.new
      end
      
      def create
       @artist= Artist.new(artist_params)
       @artist.user = current_user
       @artist.save
       redirect_to artists_path
      end

      def edit
        @artist = Artist.find(params[:id])
      end
      

      def update
        artist = Artist.find(params[:id])
        artist.update(params.require(:artist).permit(:name, :albums, :hometown, :img))
        
        redirect_to artist
      end


    private
    def artist_params
      params.require(:artist).permit(:name, :albums, :hometown, :img)
    end

    def find_todo
      @todo = Todo.find(params[:id])
    end
end
