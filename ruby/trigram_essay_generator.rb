class TrigramEssayGenerator
  def self.analyse( source )
    raise if source.nil? 
    words = source.split
    raise if words.size < 3 
    
    trigram = {}
    key = []
    words.each do |word|
      key << word
      next if key.count < 3
      pair = key[0..1]
      key.shift
      
      trigram[ pair ] ||= []
      trigram[ pair ] << word
    end
    trigram
  end
  
  def self.freq( trigrams )
    freqs = {}
    trigrams.each do |key, vals|
      vals.each do |val|
        freqs[key] ||= {}
        freqs[key][val] ||= 0
        freqs[key][val] += 1
      end
    end
    freqs
  end
  
  def self.generateRandom( source )
    trigrams = analyse( source )
    start = trigrams.keys[ Random.rand( trigrams.count - 1 ) ]
    
    output = start
    100.times do
      trigram = trigrams[ start ]
      break if trigram.nil?
      output << trigram[ Random.rand( trigram.count - 1 ) ]
      start = output[ -2..-1 ]
    end
    output.join ' '
  end
  
  def self.randomFromSource( fileName )
    file = File.open( fileName )
    source = file.read
    file.close
    
    generateRandom( source )
  end
end