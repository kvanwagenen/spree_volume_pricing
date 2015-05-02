routes = lambda do
  namespace :admin do 
    resources :products do 
       resources :variants do
        get :volume_prices, :on => :member
      end
    end

    delete '/volume_prices/:id', :to => "volume_prices#destroy", :as => :volume_price
  end

  namespace :api do
    resources :products do
      resources :variants do
        resources :volume_prices do
          put :update_batch
        end
      end
    end
  end
end

if Spree::Core::Engine.respond_to?(:add_routes)
  Spree::Core::Engine.add_routes(&routes)
else
  Spree::Core::Engine.routes.draw(&routes)
end
