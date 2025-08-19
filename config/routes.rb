Rails.application.routes.draw do
  get "home/index"
  root "home#index"

  post   "/quests",                  to: "home#create",         as: :quests
  patch  "/quests/:id/toggle_status", to: "home#toggle_status", as: :toggle_status_quest
  delete "/quests/:id",              to: "home#destroy",        as: :quest

  get "/home/brag",                   to: "home#brag",           as: :brag
end
