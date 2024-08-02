class DomainConstraint
  def initialize(domain)
    @domain = domain
  end

  def matches?(request)
    request.host.include?(@domain)
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  constraints DomainConstraint.new("bananas.education.gov.uk") do
    resource :banana, only: :show

    root "bananas#show", as: "banana_root"
  end

  constraints DomainConstraint.new("pineapples.education.gov.uk") do
    resource :pineapple, only: :show

    root "pineapples#show", as: "pineapple_root"
  end
end
