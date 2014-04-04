require 'noir'
require 'spec_helper'

describe 'Noir::Base' do

  it "is module" do
    expect(Noir::Base.class).to eq(Module)
  end

end
