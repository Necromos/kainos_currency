class CurrencyController < ApplicationController
  def index
    @currencies = Currency.all.group(:name).order(name: :asc)
  end

  def show
    @currency = Currency.find(params[:currencyCode])
  end
end
