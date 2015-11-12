require 'spec_helper'

describe Spokesman::Utils do

  # it 'encodes text as URL' do
  #   text = 'This is spec message'
  #   expect(Spokesman::Utils.urlify(text)).to eq('This%20is%20spec%20message')
  # end

  describe 'sanitizes phone numbers' do
    ['+77017777777', '7 (701) 777-77-77', '+7-701-777-7777'].each do |phone|
      it phone do
        expect(Spokesman::Utils.sanitize_phone(phone)).to eq('77017777777')
      end
    end
  end
end