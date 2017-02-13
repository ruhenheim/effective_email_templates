EffectiveEmailTemplates::Engine.routes.draw do
  if defined?(EffectiveDatatables)
    resources :email_templates, only: [:index, :edit, :update]
  end
end
