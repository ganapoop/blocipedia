Rails.configuration.stripe = {
   publishable_key: ENV['sk_test_sO3b51oFFKInkUXTmnLReTYM'],
   secret_key: ENV['stripe_api_key']
}

# Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
