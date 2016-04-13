Rails.application.routes.draw do
  root to: "root#main"
  get 'root/service', :defaults => { :format => "json" }
  get 'root/infect'
  get 'root/reset'
end
