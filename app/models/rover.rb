class Rover < ActiveRecord::Base
  belongs_to :plateau
  validates_numericality_of :x, :unless => proc { self.x.blank?}
  validates_numericality_of :y, :unless => proc { self.y.blank?}
  validates_presence_of :x, :y, :heading
  validates_format_of :heading, :with => /[NSEW]/, :message => I18n.t("rover.invalid_heading"), :unless => proc { self.heading.blank?}

  def construct rover_arguments
    unless rover_arguments.blank?
      splitted_rover_arguments = rover_arguments.split(" ")
      if splitted_rover_arguments.count == 3
        self.x = splitted_rover_arguments[0]
        self.y = splitted_rover_arguments[1]
        self.heading = splitted_rover_arguments[2]
      end
    end

  end

  def move commands
    valid_commands_list = false
    #only L,R or M are allowed in the moves string
    if(commands=~ /[LRM]/) == 0
      valid_commands_list = true
      commands_list = commands.split("")
      commands_list.each do |command|
        if command == "L"
          #rotate 90 degrees to left
          case self.heading
            when "N"
              self.heading = "W"
            when "W"
              self.heading = "S"
            when "S"
              self.heading = "E"
            when "E"
              self.heading = "N"
          end
        elsif command == "R"
          #rotate 90 degrees to right
          case self.heading
            when "N"
              self.heading = "E"
            when "E"
              self.heading = "S"
            when "S"
              self.heading = "W"
            when "W"
              self.heading = "N"
          end
        elsif command == "M"
          #move 1 cell in the current direction unless you hit the boundary of the grid
          plateau = self.plateau
          case self.heading
            when "N"
              if self.y + 1 <= plateau.vertical_cells_number
                self.y = self.y + 1
              end
            when "W"
              if self.x -  1 >= 0
                self.x = self.x - 1
              end
            when "S"
              if self.y - 1 >= 0
                self.y = self.y - 1
              end
            when "E"
              if self.x + 1 <= plateau.horizonal_cells_number
                self.x = self.x + 1
              end
          end
        end
      end
      self.save
    else
      puts "invalid moves"
    end
    return valid_commands_list
  end
end
