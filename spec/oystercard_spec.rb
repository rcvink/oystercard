require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'has a initial balance of 0' do
    expect(oystercard.balance).to eq(0)
  end

  it 'checks if the card has been topped-up' do
    expect { oystercard.top_up 1 }.to change { oystercard.balance }.by 1
  end
end
