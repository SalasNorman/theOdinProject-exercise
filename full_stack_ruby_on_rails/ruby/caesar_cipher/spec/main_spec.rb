require_relative '../main'

RSpec.describe '#caesar_cipher' do
  it 'shifts lowercase letters correctly' do
    expect(caesar_cipher("abc", 3)).to eq("def")
  end

  it 'shifts uppercase letters correctly' do
    expect(caesar_cipher("ABC", 3)).to eq("DEF")
  end

  it 'wraps around the alphabet' do
    expect(caesar_cipher("xyz", 3)).to eq("abc")
  end

  it 'preserves case' do
    expect(caesar_cipher("AbC", 2)).to eq("CdE")
  end

  it 'does not change non-alphabet characters' do
    expect(caesar_cipher("Hello, World!", 3)).to eq("Khoor, Zruog!")
  end

  it 'works with large shift values' do
    expect(caesar_cipher("abc", 29)).to eq("def") # 29 % 26 == 3
  end

  it 'works with zero shift' do
    expect(caesar_cipher("Hello", 0)).to eq("Hello")
  end

  it 'works with negative shift' do
    expect(caesar_cipher("def", -3)).to eq("abc")
  end

  it 'works with full sentence example' do
    expect(caesar_cipher("What a string!", 5)).to eq("Bmfy f xywnsl!")
  end
end