require 'iris'
require 'spec_helper'

describe 'Iris::Base' do

  it "is module" do
    Iris::Base.class.should eq(Module)
  end

end
