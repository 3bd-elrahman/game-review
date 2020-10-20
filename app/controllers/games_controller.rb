class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy,:like]
before_action :auth_admin,only:[:edit,:delete]
before_action :authenticate_user!,only:[:like,:delete,:create,:edit,:new]
  # GET /games
  # GET /games.json
  def index
    set_games_and_genre_with_criteria(params[:genre],params[:order])
   
  end

def search
    set_games_and_genre_with_criteria(params[:genre],params[:order])

end

def set_games_and_genre_with_criteria(requested_genre,requested_order)
      if requested_genre.nil? || requested_genre.blank? || requested_genre=='All'
        @games_by_genre = filter_by_order(Game.all,requested_order)
        @genre_name= 'All'

      else
        @genre_name=requested_genre

        @games_by_genre=filter_by_order(Genre.find_by(name: @genre_name).games,requested_order)

      end

    end
#filter_method
 def filter_by_order(_games,_order)
 if _order.nil? ||_order.blank?
@games= _games

elsif _order == 'A-Z'
  @games= _games.order('name ASC')

elsif _order == 'Highest Rating First'
    @games= _games.order('rating DESC')

elsif _order == 'Lowest Rating First'
    @games= _games.order('rating ASC')
elsif _order == 'Newest First'
    @games= _games.order('created_at DESC')
    elsif _order == 'Oldest First'
    @games= _games.order('created_at ASC')
  
  end
  @games
end



  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  def like
    if current_user.voted_for? @game
      @game.unliked_by current_user
    else
@game.liked_by current_user
    end
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:name,:review,:rating,:image,genre_ids:[])
    end

    
end
