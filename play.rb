require "./classes.rb"

def day
    Household.all.each do |person|
        status(person)
        
        person.energy - 2
        person.hygiene - 2
        person.hunger - 2
        person.social - 0.5
    end
    change_day
end

def change_person(name)
    if name.downcase == 'l'
        Household.all.each do |person|
            puts person.name
        end
    else
        Household.all.each do |person|
            if name == person.name
                return person
            end
        end
    end
end

def ask_change
    name = ''
    puts "Enter 'L' for the list of family members. Otherwise, please type the name of the person you'd like to be: "
    name = gets.chomp.to_s
    change_person(name)
end

def status(person)
    if person.tired?
        puts person.name + " is well rested."
    else
        puts person.name + " needs to sleep!"
    end
    
    if person.clean?
        puts person.name + " is clean."
    else
        puts person.name + " needs to bathe!"
    end
    
    if person.hunger?
        puts person.name + " is well fed."
    else
        puts person.name + " needs to eat!"
    end
    
    if person.social?
        puts person.name + " is very social."
    else
        puts person.name + " needs to talk more!"
    end
end

def change_day
    puts "Would you like to run the next day or take care of person or get a job?"
    answer = gets.chomp.to_s
    if answer.downcase == 'next day'
        day
    elsif answer.downcase == 'take care'
        take_care(ask_change)
    elsif answer.downcase == 'get a job'
        person = ask_change
        if person.type.downcase == 'adult'
            get_job(person)
        else
            puts 'You cannot get a job.'
        end
    end
    change_day
end

def take_care(person)
    puts "Would you like to eat, sleep, or bathe?"
    answer = gets.chomp.to_s
    if answer.downcase == "eat"
        go_to_eat
    elsif answer.downcase == "sleep"
        person.sleep
    elsif answer.downcase == "bathe"
        person.bathe
    end
    change_day
end

def go_to_eat
    restaraunt = '' 
    while restaraunt == ''
        puts "Type 'L' to print list of restaraunts or type name:"
        restaraunt = gets.chomp.to_s.downcase!
        if restaraunt == 'l'
            Restaraunt.all.each do |place|
                puts place.name + ' Rating: ' + place.rating + ' Price per person: ' + place.price
            end
        else
            Restaraunt.all.each do |place|
                if place.name.downcase == restaraunt
                    restaraunt = place.name
                end
            end
            puts "Who are you eating with? Press enter if you are eating by yourself."
            people = gets.chomp.split('')
            
            pay = ''
            
            people.each do |i| 
                Player.all.each do |person|
                    if i == person.name
                        i = person
                    end
                end
            end
            
            while pay == ''
                puts "Would you like to pay or use household money? ('my money' or 'household money')"
                answer = gets.chomp.to_s
                person = ask_change
                
                Restaraunt.all.each do |place|
                    if place.name.downcase == restaraunt
                        restaraunt = place
                    end
                end
                
                price = restaraunt.price * people.length+1
                
                if answer == "my money" or answer == "household money" and person.type.lower == "adult" and person.money >= price
                    if answer == 'my money'
                        'You paid ' + price + ' dollars'
                    elsif answer == 'household money'
                        'Your household paid ' + price + 'dollars'
                        adults = []
                            people.each do |i|
                                if i.type.downcase == 'adult'
                                    adults.push(i)
                                end
                            end
                        price = price/adults.length
                        adults.each do |adult|
                            adult.money - price
                        end
                    end
                    people.each do |person|
                        person.hunger + 2
                    end
                    pay = 'stop'
                else
                    'You cannot pay that way or you are not an adult'
                end
            end
        end
    end
end

def add_player
    puts "What would you like your name to be?"
    name = gets.chomp.to_s
    puts "Would you like to be a teen or adult?"
    type = gets.chomp.to_s
    
    Player.new(name, type.capitalize, true)
    
    # while household_adult? == false or answer.downcase == 'yes'
    add_new_player
    # end
end

def household_adult?
    Household.all.each do |person|
        if person.type.downcase == "adult"
            return true
        end
    end
end

def add_new_player
    puts "Would you like to make another person?"
    answer = gets.chomp.to_s
    if answer.downcase == "yes" && Player.all.length < 4
        add_player
    end
    start_game
end

def get_job(person)
    puts "What would you like to work as?"
    answer = gets.chomp.to_s
    Occupation.all.each do |job|
        if job.name.downcase == answer
            person.job(job.name)
        else
            puts "We dont have that job option"
        end
    end
    change_day
end

def start_game
    day
end

add_player