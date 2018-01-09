require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :entry_station }

  describe 'initially' do
    it 'has a initial balance of 0' do
      expect(oystercard.balance).to eq 0
    end

    it 'is not in a journey' do
      expect(oystercard.in_journey?).to be false
    end
  end

  describe '#top_up' do
    it 'checks if the card has been topped-up' do
      expect { oystercard.top_up 1 }.to change { oystercard.balance }.by 1
    end

    it 'fails to top up beyond £90' do
      fail_message = "cannot top-up, #{oystercard.balance + 100} is greater than limit of #{Oystercard::MAXIMUM_BALANCE}"
      expect { oystercard.top_up 100 }.to raise_error fail_message
    end
  end

  describe '#touch_in' do
    it 'touches in successfully' do
      oystercard.top_up(2)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    context 'when balance is below £1' do
      it 'refuses to touch in' do
        expect{ oystercard.touch_in(entry_station) }.to raise_error 'Not enough money on your card'
      end
    end

    it 'records entry station name' do
      oystercard.top_up(2)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'touches out successfully' do
      oystercard.top_up(2)
      oystercard.touch_in(entry_station)
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts the fare from my balance' do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out }.to change { oystercard.balance }.by -1
    end

    it 'sets entry station to nil on touch out' do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end
  end
end
