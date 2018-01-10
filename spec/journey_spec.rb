require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'can create an instance' do
    expect(journey).to be_an_instance_of Journey
  end

  it 'can start a journey' do
    journey.start(entry_station)
    expect(journey.start_station).to be entry_station
  end

  it 'can end a journey' do
    journey.start(entry_station)
    journey.finish(exit_station)
    expect(journey.end_station).to be exit_station
  end

  it 'calculates the minimum fare' do
    journey.start(entry_station)
    journey.finish(exit_station)
    expect(journey.fare).to eq 1
  end

  it 'calculates the penalty fare' do
    journey.finish(exit_station)
    expect(journey.fare).to eq 6
  end
end
