require 'csv'

module ActivitiesHelper

  def generate_csv_for_activities
    CSV.generate do |csv| 
      header = []
      @series.each do |s|
        header << s.rpartition('/')[2]
      end
      csv << header

      @activities.each do |product|
        row = []
        @series.each do |s|
          row << product.send(s.rpartition('/')[2])
        end
        csv << row
      end
    end
  end
end
