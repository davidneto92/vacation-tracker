class VacationsController < ApplicationController

  def show
    @vacation = Vacation.where(id: params[:id]).first
  end

  def new
    @vacation = Vacation.new
    @public_choice = [true, false]
  end

  def create
    @vacation = Vacation.new(vacation_params)
    @vacation.user_id = current_user.id

    if @vacation.save
      flash[:notice] = "Vacation created!"
      redirect_to vacation_path(@vacation)
    else
      flash[:alert] = "Vacation not created"
      render :new
    end
  end


  private

  def vacation_params
    params[:vacation][:public] = (params[:vacation][:public] == "true")
    # ^ converts string from form into a boolean
    params.require(:vacation).permit(
      :name, :location, :description, :start_date, :end_date, :public
    )
  end

end

# <div class="row">
#   <%= f.label :public, "public" %>
#   <%= f.collection_radio_buttons :public, @public_choice, :first, :last do |b| %>
#       <%= b.radio_button %>
#       <%= b.label %>
#   <% end %>
# </div>
