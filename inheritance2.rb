
class Hero

    attr_reader :stats
    attr_reader :traits
    attr_reader :quirks
		attr_reader :consang

		# attr_accessor :childstats
		# attr_accessor :childquirks
		# attr_accessor :childtraits
		# attr_accessor :childconsang

		#consang is the consanguinity seed, a representation of how genetically distinct the organism is. This tracks inbreeding.

  def initialize(name, stats, traits, quirks, consang)
    @name = name

    @stats = stats
    @traits = traits
    @quirks = quirks
		@consang = consang
  end


  def consangcombine(other)

    return @childconsang = ((@consang + other.consang) / 2 ) + rand(-50..50) if (@consang-5000...@consang+5000).include?(other.consang)


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


  def breed(other)
    p consangcombine(other)
    p statscombine(other)
    p traitscombine(other)
  end


end

#wishlist:

#weird traits like big ears, and more of them.

#more description: hair color, eye color, height, build,

#more quirks; better tutoring system

#longevity counter which determines when the person is going to die

#script that increments the age of the children and kills them as they pass their death-date


$trait_dict = {
	"10" => "Willowy: +2 Dex, -3 Str",
	"11" => "Bear Strength: +2 Str",
	"12" => "Puny: -2 Str",
	"13" => "Brainy: +2 Int",
	"14" => "Dimwitted: -2 Int",
	"15" => "Fertile: + 1 Child",
	"16" => "Low Fertility: -1 Child",
	"17" => "Hawk Eye: + 1 Atk",
	"18" => "Nearsighted: -1 Atk",
	"19"=> "Hearty: +2 Con",
	"20" => "Sickly: -2 Con",
	"21" => "Impressionable: -2 Wis",
	"22" => "Strong Willed: +2 Wis",
	"23" => "Kingmaker: More male children",
	"24" => "Queenmaker: More female children",
	"25" => "Nimble: +2 Dex",
	"26" => "Clumsy: -2 Dex",
	"27" => "Fast: +10ft Move",
	"28" => "Slow: -10ft Move",
	"29" => "Curious: +50% XP gain",
	"30" => "Slow Learner: -50% XP gain",
	"31" => "Big-Boned: +2 Con, -3 Dex.",
	"32" => "Brutish: +2 Str, -3 Dex",
	"33" => "Light Frame: +10 Speed, -2 Con",
  "34" => "High-energy: +2 CHA",
  "35" => "Sedate: -2 CHA",
}


$inbred_dict ={

	"0" => "Genius: +2 to all mental stats.",
	"1" => "Inbreeding Type 1: -2 to all physical stats",
	"2" => "Inbreeding Type 2: each child has a 50% chance of death.",
	"3" => "Hemophilia: -1 child, and every attack inflicts bleed damage.",
	"4" => "Dullard: -2 to all mental stats",
	"5" => "Fainting dog syndrome: cumulative 1/6 chance of passing out during combat.",
	"6" => "Weird birthmarks everywhere: spot spot spot.",
	"7" => "Imbecile: -4 to all mental stats",
	"8" => "Flipperhands: Flippers, instead of hands. You inbred too hard.",
	"9" => "Pygmy: Your size category is small, and you have -2 to all physical stats"
}

$quirk_dict = {
	"1" => "Alert: +1 AC",
	"2" => "Attuned: +2 Wis",
	"3" => "Berserker: Rage upon ally death",
	"4" => "Forgetful: -2 Int",
	"5" => "Bloodthirsty: temporary +1 Atk, Str, and Dex if vanquished an enemy recently",
	"6" => "NERD: +2 Int",
	"7" => "Brazen: +1 Atk",
	"8" => "Hates Children: -1 Child",
	"9" => "Clearheaded: +2 Wis",
	"10" => "Cocky: -1 AC, +1 CHA",
	"11" => "Chronic Depression: -2 Wis, -10 speed, -1 Child",
	"12" => "Quitter: -1 Atk, -1 AC, -10 speed",
	"13" => "Fainthearted: Flees upon ally death",
	"14" => "Racism: -1 Atk against those not of the hated house, +1 against them.",
	"15" => "Family Ties: +1 Atk when fighting alongside family",
	"16" => "Cautious: +1 AC, -5 Init",
	"17" => "Clean-living: Extended lifespan, vegan",
	"18" => "Gregarious: +2 Cha",
	"19" => "Sociopathic Serial Killer.",
	"20" => "Inner Peace: +2 Wis",
	"21" => "Purity of Purpose: +1 Str, Dex. +10% HP, rounding down.",
	"22" => "Irritable: -1 Atk",
	"23" => "Hermit: -1 to all stats when in a group.",
	"24" => "Athlete: +2 Str",
	"25" => "Nervous: -1 Atk",
	"26" => "Nihilistic: -2 Wis",
	"27" => "Oblivious: -4 Wis",
	"28" => "Optimistic:  :D ",
	"29" => "Attuned to the Pack: Take attacks of opportunities when adjacent allies do",
	"30" => "Passionless: -1 Child +2 Wis, -10% HP",
	"31" => "Heroic: +1 Atk, +1 AC.",
	"32" => "Pessimist: >:( ",
	"33" => "Frenetic: +4 Initiative, -1 AC",
	"34" => "Rebellious: YOU'RE NOT THE BOSS OF ME, MOM",
	"35" => "Alcoholic: +1 Str, -1 Dex, -1 Int, -1 AC.",
	"36" => "Shifty: +1 AC",
	"37" => "Sluggish: -1 AC",
	"38" => "Stalwart: +1 AC",
	"39" => "Hysterical: -1 Atk, -1 AC, -1 child",
	"40" => "Scatterbrained: -2 Wis",
	"41" => "Sound sleeper: +10% HP, hard to wake",
	"42" => "Wily: +1 AC",
	"43" => "Agreeable: Yeah!",
	"44" => "Well-traveled: +2 Int",
	"45" => "Honest: 'Yep, you're ugly.' ",
	"46" => "Musical prodigy: +1 Cha, (special abilities in fae bloodline)",
	"47" => "Cavalier: +1 melee damage, -1 Atk",
	"48" => "Exceptionally talkative:  :U  (jibberjabber intensifies)",
	"49" => "Empathetic:  +2 to Diplomacy and Sense Motive",
	"50" => "Thoughtful: +2 to Int",
	"51" => "Earnest",
	"52" => "Diehard: Bonus HP equal to CON mod. No death saves; just death.",
	"53" => "Exceptionally modest",
	"54" => "Principled",
	"55" => "Reckless: Your attacks have advantage. Attacks against you have advantage.",
	"56" => "Combat Masochist: +1 melee damage if you're not at full health",
	"57" => "Bloodlust: +1 melee damage if opponent isn't at full health",
	"58" => "Brawler: Proficiency with improvised weapons",


}


john = Hero.new("John", [10,10,10,10,10,10,] , [10, 11] , [5,6], 4000)
jane = Hero.new("Jane", [10,10,10,10,10,10,] , [20, 21] , [1,2], 3000)

john.breed(jane)
