require 'noir'
require 'spec_helper'

describe 'Noir::Command::Edit' do
  it 'is inherited Noir::Base::Command' do
    expect(Noir::Command::Edit.superclass).to eq(Noir::Base::Command)
  end

  it 'returns default editor without EDITOR environment' do
    allow(ENV).to receive(:[]).with('EDITOR').and_return(nil)
    expect(Noir::Command::Edit.editor).to eq('vim')
  end

  it 'returns editor treat EDITOR environment' do
    allow(ENV).to receive(:[]).with('EDITOR').and_return('hoge')
    expect(Noir::Command::Edit.editor).to eq('hoge')
  end
end

