class Price < ApplicationRecord
   belongs_to :product
   after_create do
      price=Stripe::Price.create({
         unit_amount: self.unit_amount*100,
         currency: 'usd',
         recurring: {interval: self.recurring_interval},
         product: self.product.stripe_product_id,
         lookup_key: self.product.name

   })
   update(stripe_product_id: self.product.stripe_product_id, stripe_price_id: price.id)
   end
end
