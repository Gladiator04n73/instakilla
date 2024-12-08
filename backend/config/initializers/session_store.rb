Rails.application.config.session_store :cookie_store, 
  key: '_instakilla_session',
  domain: :all,
  same_site: :lax
