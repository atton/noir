require 'noir'
require 'spec_helper'

describe 'Noir::Base::Command' do

  it 'is class' do
    expect(Noir::Base::Command.class).to eq(Class)
  end

  describe 'Command.description' do
    it 'raise exception if description is nil.' do
      expect{Noir::Base::Command.description}.to raise_error(RuntimeError)
    end

    it 'output description if description is not nil' do
      Noir::Base::Command.class_variable_set :@@description, "hoge"
      expect{Noir::Base::Command.description}.to output("hoge\n").to_stdout
      Noir::Base::Command.class_variable_set :@@description, nil
    end
  end

  describe 'Command.execute' do
    before { stub_const('Hoge', Class.new(Noir::Base::Command)) }

    it 'raise exception if called in not extended class' do
      expect{Noir::Base::Command.execute}.to raise_error(RuntimeError)
    end

    it 'raise exception if called in extended class but undefined description' do
      expect{Hoge.execute}.to raise_error
    end

    it 'output description if called in extended class and defined description' do
      Hoge.class_variable_set :@@description, "hoge"
      expect{Hoge.execute}.to output.to_stdout
    end
  end

  describe 'Command.sub_commands' do
    it 'return [] when not defined sub commands' do
      expect(Noir::Base::Command.sub_commands).to eq([])
    end

    describe 'when defined sub commands.' do
      before do
        stub_const('Hoge'                               , Class.new(Noir::Base::Command))
        stub_const('Hoge::SubCommand'                   , Class.new(Noir::Base::Command))
        stub_const('Hoge::SubCommand::SubSubCommand'    , Class.new(Noir::Base::Command))
        stub_const('Hoge::SubCommand::SubSubNonCommand' , Class.new)
        stub_const('Hoge::SubCommandTwo'                , Class.new(Noir::Base::Command))
        stub_const('Hoge::SubNonCommand'                , Class.new)

=begin
        # stub_const is this structure
        class Hoge < Noir::Base::Command
          class SubCommand < Noir::Base::Command
            class SubSubCommand < Noir::Base::Command
            end
            class SubSubNonCommand
            end
          end
          class SubCommandTwo < Noir::Base::Command
          end

          class SubNonCommand
          end
        end
=end

        @commands = Hoge.sub_commands
      end

      it 'return subcommands' do
        expect(@commands).to eq([:SubCommand, :SubCommandTwo])
      end

      it 'not include symbol that not inherited Noir::Base::Comand' do
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
