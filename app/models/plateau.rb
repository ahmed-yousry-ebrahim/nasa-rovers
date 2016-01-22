class Plateau < ActiveRecord::Base
  has_many :rovers
  validates_numericality_of :horizonal_cells_number, :unless => proc { self.horizonal_cells_number.blank?}
  validates_numericality_of  :vertical_cells_number, :unless => proc { self.vertical_cells_number.blank?}
  validates_presence_of :horizonal_cells_number, :vertical_cells_number
  def construct(grid_coordinates)
    unless grid_coordinates.blank?
      splitted_grid_coordinates = grid_coordinates.split(" ")
      if splitted_grid_coordinates.count == 2
        self.horizonal_cells_number = splitted_grid_coordinates[0]
        self.vertical_cells_number = splitted_grid_coordinates[1]
      end
    end
  end
end
