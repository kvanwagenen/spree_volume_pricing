Spree::Api::ApiHelpers.module_eval do
  def volume_price_attributes
    [:id, :amount, :discount_type, :name, :position, :range, :variant_id]
  end
end