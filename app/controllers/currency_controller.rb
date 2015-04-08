class CurrencyController < ApplicationController
  def index
    @currencies = Currency.select(:name,:code).group(:name, :code).order(name: :asc)
    @currencies = remove_doubles @currencies
  end

  def show
    @currency_records = Currency.where(code: params[:currencyCode]).order(date: :desc)
    respond_to do |format|
      format.html
      format.json{ render :json => @currency_records }
    end
  end

  private
    def remove_doubles(currencies)
      array = []
      currencies.each_with_index do |currency, index|
        if currencies[index+1].nil?
          array.push currency
          break
        end
        array.push currency if currency.code != currencies[index+1].code
      end
      array
    end
end
