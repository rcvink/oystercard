require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'has a initial balance of 0' do
    expect(oystercard.balance).to eq(0)
  end

  it 'checks if the card has been topped-up' do
    expect { oystercard.top_up 1 }.to change { oystercard.balance }.by 1
  end

  it 'fails to top up beyond £90' do
    fail_message = "cannot top-up, #{oystercard.balance + 100} is greater than limit of #{Oystercard::MAXIMUM_BALANCE}"
    expect { oystercard.top_up 100 }.to raise_error fail_message
  end
end
