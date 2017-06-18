require 'noir'
require 'spec_helper'

describe 'Noir::Command::Format::PDFURL' do
  it 'is inherited Noir::Base::Terminalcommand' do
    expect(Noir::Command::Format::PDFURL.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is raise exception when argument is empty' do
    expect{Noir::Command::Format::PDFURL.execute}.to raise_error(/URL Missing/)
  end

  it 'is output url from a link that is searched by google' do
    url = 'http://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CCcQFjAA&url=http%3A%2F%2Fwww.paultaylor.eu%2Fstable%2Fprot.pdf&ei=vZU9VYutJOfEmwXVqYCACQ&usg=AFQjCNFjVoGxnV_G4uQ18BzFs7z4iOPYkA&bvm=bv.91665533,d.dGY'
    expect{ Noir::Command::Format::PDFURL.execute(url) }.to output(/http:/).to_stdout
  end

  it 'is output message, if link is not valid' do
    expect{ Noir::Command::Format::PDFURL.execute('hoge') }.to output(/missing/).to_stdout
  end

  it 'is support multi URL' do
    url = 'http://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CCcQFjAA&url=http%3A%2F%2Fwww.paultaylor.eu%2Fstable%2Fprot.pdf&ei=vZU9VYutJOfEmwXVqYCACQ&usg=AFQjCNFjVoGxnV_G4uQ18BzFs7z4iOPYkA&bvm=bv.91665533,d.dGY'
    expect{ Noir::Command::Format::PDFURL.execute(url,url,url) }.to output(/http:/).to_stdout
  end
end


