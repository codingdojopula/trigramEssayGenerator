require "rubygems"
require "rspec"

require_relative "trigram_essay_generator"

describe "ruby essay generator" do
  it "should raise for incorerct data" do
    lambda { TrigramEssayGenerator.analyse( nil ) }.should raise_error
    lambda { TrigramEssayGenerator.analyse( "single" ) }.should raise_error
    lambda { TrigramEssayGenerator.analyse( "one two" ) }.should raise_error
  end
  
  it "should analyse triplet" do
    TrigramEssayGenerator.analyse( "one two three" ).should == { 
      %w( one two ) => %w( three )
    }
  end

  it "should analyse four words" do
    TrigramEssayGenerator.analyse( "one two three four" ).should == { 
      %w( one two ) => %w( three ),
      %w( two three ) => %w( four )
    }
  end

  it "should analyse repeat" do
    TrigramEssayGenerator.analyse( "one two three one two three" ).should == { 
      %w( one two ) => %w( three three ),
      %w( two three ) => %w( one ),
      %w( three one ) => %w( two ),
    }
  end

  it "should analyse kata sample data" do
    TrigramEssayGenerator.analyse( "I wish I may I wish I might" ).should == { 
      %w( I wish ) => %w( I I ),
      %w( wish I ) => %w( may might ),
      %w( I may ) => %w( I ),
      %w( may I ) => %w( wish ),
    }
  end

  it "should gen freq from kata sample data" do
    TrigramEssayGenerator.freq( TrigramEssayGenerator.analyse( "I wish I may I wish I might" ) ).should ==  { 
      %w( I wish ) => { 'I' => 2 },
      %w( wish I ) => {'may' => 1, 'might' => 1 },
      %w( I may ) => { 'I' => 1 },
      %w( may I ) => { 'wish' => 1 },
    } 
  end
end