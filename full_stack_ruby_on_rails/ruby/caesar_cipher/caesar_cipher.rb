def encryption_letter(letter, letter_position, shift)
  encrypted_position = (letter.ord - letter_position + shift) % 26
  (encrypted_position + letter_position).chr
end

# rubocop:disable Metrics/MethodLength
def caesar_cipher(text, shift)
  encrypted_text = ""
  text.chars.each do |letter|
    encrypted_letter = if /[[:upper:]]/.match?(letter)
                         encryption_letter(letter, 65, shift)
                       elsif /[[:lower:]]/.match?(letter)
                         encryption_letter(letter, 97, shift)
                       else
                         letter
                       end
    encrypted_text << encrypted_letter
  end
  encrypted_text
end
# rubocop:enable Metrics/MethodLength

# Encrypts the string "Hello World" using a Caesar cipher with a shift of 3
puts caesar_cipher("Hello World", 3)
# Khoor Zruog

puts caesar_cipher("What a string!", 5)
# Bmfy f xywnsl!

puts caesar_cipher("Like you", 2)