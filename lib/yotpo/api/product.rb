module Yotpo
  module Product
    def self.included(base)
      base.
        define_endpoint(:get_products, 'core/v3/stores/{app_key}/products').
        define_endpoint(:find_product, 'core/v3/stores/{app_key}/products/{yotpo_product_id}').
        define_endpoint(:create_product, 'core/v3/stores/{app_key}/products', method: :post).
        define_endpoint(:update_product, 'core/v3/stores/{app_key}/products/{yotpo_product_id}', method: :patch)
    end
  end
end
