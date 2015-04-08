class CurrencyController < ApplicationController
  def index
    @currencies = Currency.all
  end

  def show
    @currency = Currency.find(params[:currencyCode])
  end
end
