module Yotpo
  module ProductVariant
    def self.included(base)
      base.
        define_endpoint(:get_product_variants, 'core/v3/stores/{app_key}/products/{yotpo_product_id}/variants').

        define_endpoint(:create_product_variant,
                         'core/v3/stores/{app_key}/products/{yotpo_product_id}/variants',
                         method: :post).

        define_endpoint(:update_product_variant,
                         'core/v3/stores/{app_key}/products/{yotpo_product_id}/variants/{yotpo_variant_id}',
                         method: :patch)
    end
  end
end
