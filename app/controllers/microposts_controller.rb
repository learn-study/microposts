class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page params[:page] # この行を追加
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    retweets = Micropost.where("retweet = ?", @micropost.id)
    if retweets.present?
      retweets.each do |post|
        post.destroy
      end
    end
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def retweet
    micropost =Micropost.find(params[:id])
    current_user.microposts.create(retweet: params[:id],content: micropost.content)
    flash[:success] = "リツイートしました！"
    redirect_to request.referrer
  end

  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end