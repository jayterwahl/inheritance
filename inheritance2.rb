require_relative 'bloodline_tables.rb'
load 'children.rb'



class Hero

    attr_reader :stats
    attr_reader :traits
    attr_reader :quirks
		attr_reader :consang
    attr_reader :magic

		# attr_accessor :childstats
		# attr_accessor :childquirks
		# attr_accessor :childtraits
		# attr_accessor :childconsang

		#consang is the consanguinity seed, a representation of the genome of the organism. This tracks mage-bloodline, inbreeding, and appearance.

  def initialize(name, stats, traits, quirks, consang, magic, longevity)
    @name = name
    @stats = stats
    @traits = traits
    @quirks = quirks
		@consang = consang
    @magic = magic
  end


  def consangcombine(other)

    #The consang seeds are arranged as a ring: 0 and 10000 are adjacent to each other.

    #are the consang seeds close to each other? If so, here's the simple version.

    return @childconsang = ((@consang + other.consang) / 2 ) + rand(-50..50) if (@consang-5000...@consang+5000).include?(other.consang)

    #are they far enough that we want to loop around the other direction? Do the following

    if @consang > other.consang
      big = @consang
      small = other.consang
    else
      big = other.consang
      small = @consang
    end

    working = 10000-big
    working += small
    working = working / 2
    working += big
    working = working % 10000
    working += + rand(-50..50)
    @childconsang = working

  end


  def statscombine(other)
		i = 0
		@childstats = []
    while i < stats.count
			@childstats[i] = ((stats[i] + other.stats[i]) / 2 ) + rand(-1..1)
      i += 1
    end
    @childstats
  end



	def traitscombine(other)

		i = 0
		@childtraits = []

		while i < traits.count
			dice = rand(6)

			if dice == 0 || dice == 1
				@childtraits[i] = traits[i]

			elsif dice == 2 || dice == 3
				@childtraits[i] = other.traits[i]

      elsif dice == 4
        @childtraits[i] = (@childconsang / 400) + 10

			else
				@childtraits[i] = rand(24) + 10

			end
			i += 1
		end

		inbreeding(other) if (consang - other.consang).abs < 20
		@childtraits
	end


	def inbreeding(other)
		i = 0
		@childtraits = []

		while i < traits.count
			dice = rand(5)

			if dice == 1
				@childtraits[i] = traits[i]

			elsif dice == 2
				@childtraits[i] = other.traits[i]

			else
				@childtraits[i] = rand(10)
			end
			i += 1
		end
	end

  def magiccombine(other)
    @childmagic = [@magic[rand(2)],(other.magic[rand(2)])]
  end


  def breed(other)
    consangcombine(other)
    statscombine(other)
    traitscombine(other)
    magiccombine(other)

    write_to_file

    Hero.new("name", @childstats, @childtraits, nil, @childconsang, @childmagic, nil)


  end


  def write_to_file

  end


end

#wishlist:

#pretty phenotype print, which describes the characters without saying their attributes directly.
# "The child is male, with blonde hair and brown eyes. They look strong. Miscellaneous other features are: reptilian scales."


#more quirks; better tutoring system


#longevity counter which determines when the person is going to die


#script that increments the age of the children and kills them as they pass their death-date


#p (9999 % 100) * 100


# john = Hero.new("John", [10,10,10,10,10,10,] , [10, 10, 10] , [5,5,5], 4000)
# jane = Hero.new("Jane", [10,10,10,10,10,10,] , [10, 10, 10] , [5,5,5], 4500)


File.open('children.rb', 'r').each do |line|
  h = eval(line)
  variable_name = h[:name]
  instance_variable_set("@#{variable_name}", Hero.new(h[:name], h[:stats], h[:traits], h[:quirks], h[:consang], h[:magic], h[:longevity]))
end


p @john.breed(@jane)
