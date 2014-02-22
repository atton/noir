require 'iris'
require 'spec_helper'

describe 'Iris::Base' do

  it "is module" do
    expect(Iris::Base.class).to eq(Module)
  end

end
