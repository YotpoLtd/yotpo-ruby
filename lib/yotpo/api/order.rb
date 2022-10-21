module Yotpo
  module Order
    def self.included(base)
      base.
        define_endpoint(:get_orders, 'core/v3/stores/{app_key}/orders').
        define_endpoint(:find_order, 'core/v3/stores/{app_key}/orders/{yotpo_order_id}').
        define_endpoint(:create_order, 'core/v3/stores/{app_key}/orders', method: :post).
        define_endpoint(:update_order,  'core/v3/stores/{app_key}/orders/{yotpo_order_id}', method: :patch)
    end
  end
end
