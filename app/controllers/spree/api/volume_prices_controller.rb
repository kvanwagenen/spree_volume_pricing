module Spree
  module Api
    class VolumePricesController < Spree::Api::BaseController

      before_filter :load_variant

      def load_variant
        @variant = Spree::Variant.find(params[:variant_id])
      end

      def index
        if params[:ids]
          @volume_prices = Spree::VolumePrice.where(:id => params[:ids].split(','))
        else
          @volume_prices = Spree::VolumePrice.where(:variant_id => @variant.id).scoped.ransack(params[:q]).result
        end
        respond_with(@volume_prices)
      end

      def show
        @volume_price = Spree::VolumePrice.find(params[:id])
        respond_with(@volume_price)
      end

      def create
        authorize! :create, Spree::VolumePrice        
        @volume_price = @variant.volume_prices.build(params[:volume_price])
        if @volume_price.save
          render :show, :status => 201
        else
          invalid_resource!(@volume_price)
        end
      end

      def update
        authorize! :update, Spree::VolumePrice
        @volume_price = Spree::VolumePrice.find(params[:id])
        if @volume_price.update_attributes(params[:volume_price])
          render :show
        else
          invalid_resource!(@volume_price)
        end
      end

      def update_batch

      end

      def destroy
        authorize! :destroy, Spree::VolumePrice
        @volume_price = Spree::VolumePrice.find(params[:id])
        @volume_price.destroy
        render :text => nil, :status => 204
      end
    end
  end
end