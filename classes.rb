# must be inheritance
class Player
    @@all = []
    
    def self.all
        @@all
    end

    def initialize(name, type, household, age = 0, health = 10, hygiene = 10, love = 10, energy = 10, hunger = 10, social = 10, job = '')
        @name = name
        @type = type
        @age = age
        @household = household
        @health = health
        @hygiene = hygiene
        @love = love
        @energy = energy
        @hunger = hunger
        @social = social
        @job = job
        
        @friend_list = []
        
        @@all << self
        
        eval(@type).new(@name)

        if household == true
            Household.new(@name, @type)
        end
    end
    
    attr_accessor :name, :type, :age, :health, :hygiene, :love, :energy, :hunger, :social, :job
    
    # actions
    def bathe
        puts "You have showered!"
        hygiene += 2
        @hygiene = hygiene=(@hygiene)
    end
    
    def sleep
        puts "You have showered!"
        energy + 2
        @energy = energy=(@energy)
    end
    
    def eat
        puts "You have eatten!"
        hunger + 2
        @hunger = hunger=(@hunger)
    end
    
    def doctor_visit
        puts "You went to the doctor"
        health + 2
        @health = health=(@health)
    end
    
    def get_sick
        puts "You have gotten sick. You should go to the doctor."
        health - 2
        @health = health=(@health)
    end
    
    # data balance
    def energy=(energy)
        if energy > 10
            energy = 10
        elsif energy <= 0
            energy = 0
        end
        @energy = energy
    end
    
    def hygiene=(clean)
        if clean > 10
            clean = 10
        elsif clean <= 0
            clean = 0
        end
        @hygiene = clean
    end
    
    def hunger=(hungry)
        if hungry > 10
            hungry = 10
        elsif hungry <= 0
            hungry = 0
        end
        @hunger = hungry
    end
    
    def health=(health)
        if health > 10
            health = 10
        elsif health <= 0
            health = 0
        end
        @health = health
    end
    
    def job=(job)
        @job = job
    end
    
    #check if true
    def tired?
        if @energy > 7
            true
        else
            false
        end
    end
    
    def clean?
        if @hygiene > 7
            true
        else
            false
        end
    end
    
    def hunger?
        if @hunger > 7
            true
        else
            false
        end
    end
    
    def social?
        if @social > 7
            true
        else
            false
        end
    end
    
    #make friends
    def make_friend(friend)
        friend_list.append(friend)
    end
    
    def friend_list
        @friend_list
    end
    
    def talk_to_friend(person,friend)
    end
end

class Teen < Player
    @@teens = []
    
    def self.all
        @@teens
    end
    
    def initialize(name, hormones = 0)
        @name = name
        @hormones = hormones
        
        @@teens << self
    end
    
    def hormones
        @hormones
    end
end

class Household < Player
    @@people = []
    
    def self.all
        @@people
    end
    
    def initialize(name, type, money = household_money)
        super
        @name = name
        @money = money
        
        @@people << self
    end
    
    def money
        @money
    end
    
    def household_money
        money = 0
        @@people.each do |person|
            if person.type.downcase == "adult"
                money + person.money
            end
        end
        money
    end
end

class Adult < Player
    @@adults = []
    
    def self.all
        @@adults
    end
    
    def initialize(name, money = 500)
        @name = name
        @money = money
        
        @@adults << self
    end
    
    def money
        @money
    end
    
    def get_paid(salary)
        @money+=salary
        "You got paid " + salary + ' dollars!'
    end
end

class Occupation
    @@jobs = []
    
    def self.all
        @@jobs
    end
    
    def initialize(name, salary)
        @name = name
        @salary = salary
        @@job << self
    end
    
    def name
        @name
    end
    
    def salary
        @salary
    end
end

class School
    @@schools = []
    
    def self.all
        @@schools
    end
    
    def initialize(name, rating)
        @name = name
        @rating = rating
        @@schools << self
    end
    
    def name
        @name
    end
    
    def rating
        @rating
    end
end

class Restaraunt
    @@restaraunt = []
    
    def self.all
        @@restaraunt
    end
    
    def initialize(name, rating, price)
        @name = name
        @rating = rating
        @price = price
        @@restaraunt << self
    end
    
    def name
        @name
    end
    
    def rating
        @rating
    end
    
    def price
        @price
    end
end