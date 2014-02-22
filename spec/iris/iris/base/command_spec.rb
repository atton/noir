require 'iris'
require 'spec_helper'

describe 'Iris::Base::Command' do

  it 'is class' do
    expect(Iris::Base::Command.class).to eq(Class)
  end

  it 'raise exception when call description if description is nil.' do
    expect {Iris::Base::Command.description}.to raise_error(RuntimeError)
  end

  it 'output description if description is not nil' do
    Iris::Base::Command.class_variable_set :@@description, "hoge"
    expect {Iris::Base::Command.description}.to output("hoge\n").to_stdout
  end

end
