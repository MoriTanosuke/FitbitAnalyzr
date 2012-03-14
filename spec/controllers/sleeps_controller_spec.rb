require 'spec_helper'

describe SleepsController do
  it "should update data for a given date" do
    # stub out to avoid calls to fitbit
    subject.stub(:api_response) {
      '{"sleep/minutesAsleep":[{"dateTime":"1970-01-01","value":1},{"dateTime":"1970-01-02","value":2}]}'
    }

    api = subject.reload_range(['minutesAsleep'], '1970-01-01', '1970-01-02')
    api['sleep/minutesAsleep'][0]['value'].should eq(1)
  end
end

