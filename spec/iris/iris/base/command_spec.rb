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

    it 'raise exception if called in extended class but undefined description' do
      class Hoge < Iris::Base::Command
      end
      expect{Hoge.execute}.to raise_error
    end

    it 'output description if called in extended class and defined description' do
      class Hoge < Iris::Base::Command
      end
      Hoge.class_variable_set :@@description, "hoge"
      expect{Hoge.execute}.to output.to_stdout
      Hoge.class_variable_set :@@description, nil
    end
  end

  describe 'Command.sub_commands' do
    it 'return [] when not defined sub commands' do
      expect(Iris::Base::Command.sub_commands).to eq([])
    end

    describe 'when defined sub commands.' do
      before(:all) do
        class Hoge < Iris::Base::Command
          class SubCommand < Iris::Base::Command
            class SubSubCommand < Iris::Base::Command
            end
            class SubSubNonCommand
            end
          end
          class SubCommandTwo < Iris::Base::Command
          end

          class SubNonCommand
          end
        end

        @commands = Hoge.sub_commands
      end

      it 'return subcommands' do
        expect(@commands).to eq([:SubCommand, :SubCommandTwo])
      end

      it 'not include symbol that not inherited Iris::Base::Comand' do
        expect(@commands).not_to include(:SubNonCommand)
      end

      it 'not include symbol that subsub command' do
        expect(@commands).not_to include(:SubSubCommand)
      end

      it 'not include self' do
        expect(@commands).not_to include(:Hoge)
      end

      describe 'in sub command' do
        before { @commands = Hoge::SubCommand.sub_commands }

        it 'return sub sub command' do
          expect(@commands).to eq([:SubSubCommand])
        end

        it 'not include sub sub non command' do
          expect(@commands).not_to include(:SubSubNonCommand)
        end

        it 'not include sub command' do
          expect(@commands).not_to include(:SubCommand, :SubCommandTwo, :SubNonCommand)
        end

        it 'not include self class' do
          expect(@commands).not_to include(:SubCommand)
        end

      end
    end

  end
end
