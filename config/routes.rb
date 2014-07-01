Spree::Core::Engine.routes.append do
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

