#dear future aaron. This code works. I know it's terrible. But it works. Don't fuck with it.

#oh god, are you fucking with it


$trait_dict = {
	"1" => "Bear Strength: +2 Str",
	"2" => "Puny: -2 Str",
	"3" => "Brainy: +2 Int",
	"4" => "Dimwitted: -2 Int",
	"5" => "Fertile: + 1 Child",
	"6" => "Low Fertility: -1 Child",
	"7" => "Hawk Eye: + 1 Atk",
	"8" => "Nearsighted: -1 Atk",
	"9"=> "Hearty: +2 Con",
	"10" => "Sickly: -2 Con",
	"11" => "Impressionable: -2 Wis",
	"12" => "Strong Will: +2 Wis",
	"13" => "Kingmaker: More male children",
	"14" => "Queenmaker: More female children",
	"15" => "Nimble: +2 Dex",
	"16" => "Clumsy: -2 Dex",
	"17" => "Fast: +10ft Move",
	"18" => "Slow: -10ft Move",
	"19" => "Curious: +50% XP gain",
	"20" => "Slow Learner: -50% XP gain",
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
	"11" => "Chronic Depression: -2 Wis, -10 speed",
	"12" => "Quitter: -1 Atk, -1 AC, -10 speed",
	"13" => "Fainthearted: Flees upon ally death",
	"14" => "Racism: -1 Atk against those not of the hated house, +1 against them.",
	"15" => "Family Ties: +1 Atk when fighting alongside family",
	"16" => "Cautious: +1 AC, -5 Init",
	"17" => "Clean-living: Extended lifespan, vegan",
	"18" => "Insightful: +2 Wis",
	"19" => "Sociopathic Serial Killer.",
	"20" => "Inner Peace: +2 Wis",
	"21" => "Purity of Purpose: +1 Str, Dex. +10% HP, rounding down.",
	"22" => "Irritable: -1 Atk",
	"23" => "Hermit: -1 to all stats when in a group.",
	"24" => "Athlete: +2 Str",
	"25" => "Nervous: -1 Atk",
	"26" => "Nihilistic: -2 Wis",
	"27" => "Oblivious: -2 Wis",
	"28" => "Optimistic:  :D ",
	"29" => "Pack Thinker: Can take attacks of opportunities when adjacent allies do",
	"30" => "Passionless: -1 Child +2 Wis, -10% HP",
	"31" => "110%: +1 Atk, AC. +10ft move",
	"32" => "Pessimist: >:| ",
	"33" => "Reckless: +4 Initiative, -1 AC",
	"34" => "Rebellious: (remove personality traits shared with parents or trainers)",
	"35" => "Alcoholic: +1 Str, -1 Dex, Int, AC.",
	"36" => "Shifty: +1 AC",
	"37" => "Sluggish: -1 AC",
	"38" => "Stalwart: +1 AC",
	"39" => "Hysterical: -1 Atk, AC, child",
	"40" => "Scatterbrained: -2 Wis",
	"41" => "Sound sleeper: +10% HP, hard to wake",
	"42" => "Wily: +1 AC",
	"43" => "Withdrawn: Does not pass on personality traits to others",
	"44" => "Well-traveled: +2 Int",
	"45" => "Honest: 'Yep, you're fat.' ",
	"46" => "Big-Boned: +2 Con, -3 Dex, fat. Just fat.",
	"47" => "Brutish: +2 Str, -3 Dex",
	"48" => "Light Frame: +10 Speed, -2 Con",
	"49" => "Cavalier: +1 melee damage, -1 Atk",
	"50" => "Exceptionally talkative:  :U  (jibberjabber intensifies)",
	"51" => "Genius: +2 to all mental stats.",
	"52" => "Inbreeding Type 1: -2 to all physical stats",
	"53" => "Inbreeding Type 2: each child has a 50% chance of death.",
	"54" => "Hemophilia: -1 child, and every attack inflicts bleed damage.",
	"55" => "Imbecile: -2 to all mental stats",
	"56" => "Fainting dog syndrome: cumulative 1/10 chance of passing out during combat.",
	"57" => "Weird birthmarks everywhere: spot spot spot.",
	"58" => "HellaGenius: +4 to all mental stats",
	"59" => "Musical prodigy: +1 Cha, (special abilities in fae bloodline)"

}



class Hero

    attr_reader :stats
    attr_reader :traits
    attr_reader :personality

  def initialize(name, stats, traits, personality)
    @name = name
    @stats = stats
    @traits = traits
    @personality = personality
  end

  def statscombine(others)
    i = 0
    out = []
    while i < stats.count

      dice = rand(6) + 1
      if dice == 3
        dice = 2
      end
      if dice == 4 or dice == 5
        dice = 3
      end
      if dice == 6
        dice = 4
      end

      out << (((@stats[i] + others[i]) / 2) + dice - 2)
      i += 1
    end
    out
  end

  def traitscombine(others)

      out = []
      i = 0

      #60% chance of inheriting a trait
      while i < @traits.count
        coin = rand(10)
        if coin <= 5
            out << @traits[i]
        end
        i += 1
      end

	  i = 0
      #60% from the other parent
      while i < others.count
        coin = rand(10)
        if coin <= 5
            out << others[i]
        end
        i += 1
      end

      #add the random trait
      d20 = 1 + rand(20)
      out << d20

      #beef up traits, if we have too few
      while out.count < 3
        d20 = 1 + rand(20)
        out << d20
      end

      #now, trim down to 3 traits if we have too many
      while out.count > 3
          dice = rand(out.count)
          out.delete_at(dice)
      end

      #convert our array of keys into human readable text
      wordout = []


      out.map! do |val|
        val = val.to_s
      end

      i = 0
      while i < out.count
        wordout << $trait_dict[((out[i].to_i)).to_s]
		wordout << $trait_dict.keys[out[i].to_i - 1]
        i += 1
      end


      #return the child trait array
      wordout

  end

  def personalitycombine(other)


      i = 0
      out = []

      #33% chance of inheriting a trait
      while i < @personality.count
        coin = rand(3)
        if coin == 1
            out << @personality[i]
        end
        i += 1
      end
      i = 0

      #33% from the other parent
      while i < other.count
        coin = rand(3)
        if coin == 1
            out << other[i]
        end
        i += 1
      end

      #add the random quirk
      d50 = 1 + rand(50)
      out << d50

      #beef up quirks, if we have too few
      while out.count < 3
        d50 = 1 + rand(50)
        out << d50
      end

      #now, trim down to 3 quirks if we have too many
      while out.count > 3
          dice = rand(out.count)
          out.delete_at(dice)
      end

      #convert our array of keys into human readable text
      wordout = []
      i = 0


      out.map! do |val|
        val = val.to_s
      end

      while i < out.count
        wordout << $quirk_dict[out[i]]
		wordout << $quirk_dict.keys[out[i].to_i - 1]
        i += 1
      end


      #return the child trait array
      wordout

  end

  def breed(other)
     puts statscombine(other.stats)
     puts traitscombine(other.traits)
     puts personalitycombine(other.personality)

  end


  def teach(child)
	out = child
	i = 0

	#50% from the mentor
      while i < @personality.count
        coin = rand(2)
        if coin == 1
            out.personality << @personality[i]
        end
        i += 1
      end

      #now, trim down to 3 quirks if we have too many
      while out.personality.count > 3
          dice = rand(out.personality.count)
          out.personality.delete_at(dice)
      end

	  #convert our array of keys into human readable text
      wordout = []
      i = 0


      out.personality.map! do |val|
        val = val.to_s
      end

      while i < out.personality.count
        wordout << $quirk_dict[out.personality[i]]
		wordout << $quirk_dict.keys[out.personality[i].to_i - 1]
        i += 1
      end


      #return the child trait array
      wordout
  end

end

john = Hero.new("John", [10,10,10,10,10,10,] , [10, 10, 10] , [5,5,5])
jane = Hero.new("Jane", [10,10,10,10,10,10,] , [10, 10, 10] , [5,5,5])

# gen 3
rando = Hero.new("Rando", [(rand(9) + 6), (rand(9) + 6), (rand(9) + 6), (rand(9) + 6), (rand(9) + 6), (rand(9) + 6)] , [rand(21), rand(21), rand(21)], [rand(51), rand(51), rand(51)])

danielle = Hero.new("Danielle", [9,0,15,14,11,10] , [8,9,6], [27,31,10])

gregory = Hero.new("Gregory", [10,9,14,10,9,9] , [17,10,9], [46,41])

johanna = Hero.new("Johanna", [10,9,14,10,9,9] , [17,10,5], [ 35,38,8])

persephone = Hero.new("Persephone", [12,10,14,9,9,8] , [5,5,16], [27,34])

enoby = Hero.new("Enoby", [10,10,12,11,10,13] , [6,7,19], [29,46,50])

omega = Hero.new("Omega", [11,10,11,8,11,13] , [3,7,13], [26,30,8])

aurelia = Hero.new("Aurelia", [10,14,15,12,11,16] , [5,4,12], [44,1,25])

adelaide = Hero.new("Adelaide", [11,15,14,10,12,14] , [17,14,14], [1,7,44])

#gen 4
barbarian = Hero.new("Barbarian", [16,15,14,10,8,10] , [13,17,10], [3,8,46])

wizard = Hero.new("Wizard", [12,12,12,18,12,10] , [5,10,15], [21,31,43])

fae = Hero.new("Fae", [11,15,14,10,12,16] , [1,14,3], [7,13,27])

rogue = Hero.new("Vanka", [12,18,14,15,12,14] , [17,6,7], [36,48,49])

joey = Hero.new("Joey", [12,12,12,12,12,12] , [17,17,15], [12,47,49])

tenet = Hero.new("Tenet", [12,10,12,18,12,8],[19,3,2],[35,29,21])

midwife = Hero.new("Midwife", [12,12,12,10,16,10], [1,5,10], [3,23,43])

hardy = Hero.new("Hardy", [13,11,11,9,16,10], [5,5,17], [3,29,20])

#generation 5

genevieve = Hero.new("Genevieve", [12,14,13,13,11,12], [14,8,2], [1,38,7])

simon = Hero.new("Simon", [12,9,14,14,11,10], [5,16,12],[35,16,22])

esteban = Hero.new("Esteban", [12,11,12,14,10,9], [5,19,3], [27,21,7])

bubuleh = Hero.new("Bubeleh", [13,12,12,11,10,11], [17,17,13], [38,8,25])

kansas = Hero.new("Kansas", [10,11,12,12,9,11], [17,17,15], [12,48,49])

hubble = Hero.new("Hubble", [12,11,12,9,14,12], [5,17,20], [1,29,37])

miridin = Hero.new("Adelheid", [13,12,15,12,15,14], [5,4,12], [34])

inbred = Hero.new("Inbred", [9,9,9,16,16,16], [6,10,19], [51,52,54])

harvey = Hero.new("harvey", [13,11,13,10,18,10], [5,5,7], [3,46,18])

lucy = Hero.new("lucy", [17,16,14,10,7,11], [17,17,10], [32,8,6])

# generation 6

vincent = Hero.new("Vincent", [13,12,12,16,13,12], [14,10,5], [7,7,14])

genevievejr = Hero.new("genevievejr", [13,13,12,16,13,10], [5,10,13], [1,43,47])

kleborp = Hero.new("kleborp", [12,12,13,12,13,14], [12,17,7], [29,29,41])

herk = Hero.new("herk", [13,12,13,10,11,12], [17,31,12], [48,19,2])

tostito = Hero.new("tostito", [10,12,12,11,9,12], [17,15,13], [49,38,26])

ellen = Hero.new("ellen", [13,14,14,13,10,13], [3,17,7], [7,48,38])

ed = Hero.new("ed", [13,16,14,15,10,11], [5,3,6], [27,48,18])

neph = Hero.new("neph", [11,10,13,10,15,13], [5,5,7], [29,46,7])

leorick = Hero.new("leo", [13,11,11,11,17,11], [5,5,7], [1,31,50])

sampson = Hero.new("sam", [14,12,11,8,15,13], [5,6,7], [18,2,25])

creed = Hero.new("Creed", [15,15,15,12,12,11], [5,4,19] , [32,8,15])

koko = Hero.new("koko", [11,12,12,9,14,12], [5,7,3] , [7,29,48])

verruca = Hero.new("verruca", [11,14,16,12,11,17], [12,5,8] , [44,1,32])

#generation 7

britbrit = Hero.new("britbrit", [14,14,13,14,12,11], [13,5,2] , [31,43,24])

kentuckyjake = Hero.new("jake", [12,13,11,12,9,13], [15,13,8] , [38,26.49])

manassas = Hero.new("manassas", [12,13,13,14,13,14], [12,17,8] , [29,29,28])

karakas = Hero.new("karakas", [9,9,13,15,16,15], [7,10, 8] , [51,54,32])

krom = Hero.new("krom", [11,14,16,12,11,17], [12,5,8] , [44,1,32])

kreed = Hero.new("kreed", [16,16,16,12,13,11], [19,19,1] , [15,8,35])

leon = Hero.new("Leon", [11,11,14,15,10,13], [12,8,10], [44,1,50])

rwanda = Hero.new("rwanda", [12,12,12,17,10,12], [17,5,17], [43,19,27])

lusitania = Hero.new("lucy", [11,12,12,19,14,12], [5,7,3], [7,29,48])

alexandrite = Hero.new("lex", [13,15,13,15,12,11], [17,10,11], [21,47,31])

#generation 8
dor = Hero.new("lucy", [14,16,16,13,12,13], [19,11,6], [8,40,51])

duroc = Hero.new("duroc", [9,11,13,16,15,15], [7,8,16], [54,41,40])

glargl = Hero.new("lucy", [12,13,11,16,14,11], [13,3,8], [31,29,24])

sephora = Hero.new("lucy", [12,12,11,18,13,13], [17,13,7], [43,43,25])

flipper = Hero.new("lucy", [13,13,14,18,13,10], [13,7,6], [31,5,50])

elmer = Hero.new("lucy", [11,12,15,15,11,17], [12,12,10], [1,50,27])

leslie = Hero.new("lucy", [12,13,14,11,11,13], [12,12,1], [2,37,32])

choram = Hero.new("lucy", [18,12,16,18,8,8], [7,12,1], [9,38,26])

rollingsford = Hero.new("lucy", [8,10,12,16,12,14], [1,4,7], [1,4,49])


#generation 9

maul = Hero.new("lucy", [14,17,18,13,11,13], [19,11,11], [8,51,50])

mal = Hero.new("lucy", [13,12,15,18,12,11], [7,7,54], [9,10,10])


#puts leslie.breed(elmer)

puts rando.breed(rando)
