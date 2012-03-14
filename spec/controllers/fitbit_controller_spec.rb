require 'spec_helper'

describe FitbitController do
  describe "get series" do
    it "should return different series" do
      subject.get_series('sleep').should eq(['startTime', 'timeInBed', 'minutesAsleep', 'awakeningsCount', 'minutesAwake', 'minutesToFallAsleep', 'minutesAfterWakeup', 'efficiency'].collect {|s| 'sleep/' + s})
      subject.get_series('body').should eq(['weight', 'bmi', 'fat'].collect {|s| 'body/' + s})
      subject.get_series('activities').should eq(['calories', 'steps', 'distance', 'minutesSedentary', 'minutesLightlyActive', 'minutesFairlyActive', 'minutesVeryActive', 'activeScore', 'activityCalories'].collect {|s| 'activities/' + s})
    end
  end
end
