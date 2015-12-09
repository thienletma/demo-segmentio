class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate, except: [:index, :show]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = current_user.articles.find(params[:id])
    @current_user = current_user
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        #segment track created an article
        segment_track_created_article_by_user(current_user, @article);

        format.html { redirect_to @article, notice: t('articles.create_success') }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = current_user.articles.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: t('articles.update_success') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def notify_friend
    @article = Article.find(params[:id])
    Notifier.email_friend(@article, params[:name], params[:email]).deliver
    redirect_to @article, :notice => t('articles.notify_friend_success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :location, :excerpt, :body, :published_at, :category_ids => [])
    end
end
