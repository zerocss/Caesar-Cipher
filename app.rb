require "sinatra"
require "sinatra/reloader"

get "/" do
    caesar = params["caesar"].to_s
    shift = params["shift"].to_i
    if(caesar != nil && shift != nil)
        cipher = caesar_cipher(caesar, shift)
    else
        cipher = ""
    end
    erb :index, :locals => {:caesar => caesar, :shift => shift, :cipher => cipher}
end


def caesar_cipher(string, shift)
    # variable to hold new letter
    new_letter = ""
    # Array to hold the new letters pushed from the original string
    cipher_array = []
    # Split the string into an array
    string_array = string.split("")
    # Use a foreach loop to iterate over every character
    string_array.each do |letter|
        # If the current iteration is a letter a through z or A-Z
        if letter =~ (/[a-zA-Z]/)
            # Loop however many times the shift says
            shift.times do
                # Do next! so that the change stays through each loop
                new_letter = letter.next!
            end
            # if the iteration comes back with more than one character, take out the character at index 1
            if new_letter.length > 1
                new_letter[0] = new_letter[1]
                new_letter[1] = ""
            end
            # push the new letter to the cipher array
            cipher_array.push(new_letter)
        else
            # This is here to keep punctuation and white space untouched
            cipher_array.push(letter)
        end
    end
    # returns the array as a completely joined string
    return cipher_array.join
end
