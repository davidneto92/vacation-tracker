class HomeController < ApplicationController
  def show
    @total_vacations = Vacation.all.length
    @total_visits = Visit.all.length
    @total_parks = Park.all.length
  end

  def about
  end

end
