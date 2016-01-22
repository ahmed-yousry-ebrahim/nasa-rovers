class HomeController < ApplicationController
  def new

  end

  def results
    valid_input = true
    @rovers = []
    plateau_data = params[:plateau_data]
    unless plateau_data.blank?
      splitted_plateau_data = plateau_data.split("\n");
      @plateau = Plateau.new
      @plateau.construct(splitted_plateau_data.first)
      unless @plateau.valid?
        valid_input = false
      else
        @plateau.save!
        (1...splitted_plateau_data.count).step(2) do |index|
          rover = Rover.new
          rover.plateau = @plateau
          rover.construct(splitted_plateau_data[index])
          unless rover.valid?
            valid_input = false
          else
            rover.save!
            valid_input = rover.move(splitted_plateau_data[index+1])
          end

          unless valid_input
            #break the loop if one rover failed
            break
          end
        end
      end
    else
      redirect_to(root_path,:alert => t("errors.required"))
    end
    puts valid_input
    unless valid_input
      redirect_to(root_path,:alert => t("errors.parsing"))
    end

  end
end
