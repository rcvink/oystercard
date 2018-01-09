require 'station'


describe Station do

  let(:name) { double :name }
  let(:zone) { double :zone }
  subject(:station) { described_class.new(name,zone)}

  it 'should have a name' do
    expect(subject.name).to eq name
  end
  it 'should contain a zone' do
    expect(subject.zone).to eq zone
  end

end
