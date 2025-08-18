class HomeController < ApplicationController
  def index
    @quest = Quest.new
    @quests = Quest.order(created_at: :desc)
  end

  def create
    @quest = Quest.new(quest_params)

    if @quest.save
      redirect_to root_path
    else
      @quests = Quest.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def toggle_status
    @quest = Quest.find(params[:id])
    @quest.update(status: !@quest.status)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def quest_params
    params.require(:quest).permit(:title)
  end
end
