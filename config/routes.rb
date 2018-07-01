Rails.application.routes.draw do
    # get 'welcome/index'
    root 'welcome#index'

    get 'api/autocomplete/db', :to => 'api#autocomplete_database'
    get 'api/autocomplete/es', :to => 'api#autocomplete_elasticsearch'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
