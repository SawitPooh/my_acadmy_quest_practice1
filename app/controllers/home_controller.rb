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

  private

  def quest_params
    params.require(:quest).permit(:title)
  end
end
