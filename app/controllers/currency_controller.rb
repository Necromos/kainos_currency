class CurrencyController < ApplicationController
  def index
    @currencies = Currency.all.group(:id,:code).order(name: :asc)
  end

  def show
    @currency_records = Currency.where(code: params[:currencyCode]).order(date: :desc)
    respond_to do |format|
      format.html
      format.json{ render :json => @currency_records }
    end
  end
end
