require 'noir'
require 'spec_helper'

describe 'Noir::Command::Calculate::Time' do
  it 'is inherited Noir::Base::TerminalCommand' do
    expect(Noir::Command::Calculate::Time.superclass).to eq(Noir::Base::TerminalCommand)
  end

  it 'is raise exception when non-arguments' do
    expect{ Noir::Command::Calculate::Time.execute }.to raise_error
  end

  describe '.extract_directory' do
    before do
      @paths = 10.times.map{Random.rand.to_s}
      @path  = @paths.first
    end

    def path_is_not_file path
      allow(File).to receive(:exists?).with(path).and_return(false)
    end

    def path_is_file path
      allow(File).to receive(:exists?).with(path).and_return(true)
      allow(File).to receive(:file?).with(path).and_return(true)
    end

    def path_is_directory path
      allow(File).to receive(:exists?).with(path).and_return(true)
      allow(File).to receive(:file?).with(path).and_return(false)
      allow(File).to receive(:directory?).with(path).and_return(true)
    end

    it 'is raise when not found file path.' do
      path_is_not_file @path
      expect{ Noir::Command::Calculate::Time.extract_path(@path) }.to raise_error(RuntimeError, /^File not/)
    end

    it 'is return raw path by exist file path' do
      @paths.each do |path|
        path_is_file @path
        expect(Noir::Command::Calculate::Time.extract_path(@path)).to eq(@path)
      end
    end

    it 'is return extracted path by exist directory path' do
      @paths.each do |path|
        path_is_directory @path
        allow(Dir).to receive(:entries).with(@path).and_return([@path])
        expect(Noir::Command::Calculate::Time.extract_path(@path)).to eq([@path])
      end
    end

    it 'is return extracted path rejected start_with by exist directory path' do
      path_is_directory @path
      allow(Dir).to  receive(:entries).with(@path).and_return(['aaa', '.aaa', 'bbb', '.bbb', 'ccc'])
      expect(Noir::Command::Calculate::Time.extract_path(@path)).to eq(["aaa", "bbb", "ccc"])
    end
  end

end
