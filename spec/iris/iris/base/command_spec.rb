require 'iris'
require 'spec_helper'

describe 'Iris::Base::Command' do

  it 'is class' do
    expect(Iris::Base::Command.class).to eq(Class)
  end

  describe 'Command.description' do
    it 'raise exception if description is nil.' do
      expect{Iris::Base::Command.description}.to raise_error(RuntimeError)
    end

    it 'output description if description is not nil' do
      Iris::Base::Command.class_variable_set :@@description, "hoge"
      expect{Iris::Base::Command.description}.to output("hoge\n").to_stdout
      Iris::Base::Command.class_variable_set :@@description, nil
    end
  end

  describe 'Command.execute' do
    it 'raise exception if called in not extended class' do
      expect{Iris::Base::Command.execute}.to raise_error(RuntimeError)
    end

    it 'not raise exception if called in extended class' do
      class Hoge < Iris::Base::Command
      end
      expect{Hoge.execute}.not_to raise_error
    end
  end

end
