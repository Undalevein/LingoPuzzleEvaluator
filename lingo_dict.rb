class LingoDict

  # List is ordered alphabetical
  @@wordlist = File.readlines("data/english_words.txt").map(&:chomp)
  @@size = @@wordlist.length

  def self.contains(target)
    # Uses binary search to find the target.
    left = 0
    right = @@size - 1
    while left <= right
      middle = left + (right - left) / 2
      if @@wordlist[middle] == target
        return true
      elsif @@wordlist[middle] < target
        left = middle + 1
      else
        right = middle - 1
      end
    end
    return false
  end

end

def assert(bool)
  unless (bool)
    throw "Assertion Failed!"
  end
end

def test
  # Tests all of the words in the dictionary.
  LingoDict.class_variable_get(:@@wordlist).each_with_index do |word, i|
    assert(LingoDict.contains(word))
  end
  
  # Tests if these words are not in the dictionary.
  assert(!LingoDict.contains("oifiogjdosigjdoifg"))
  assert(!LingoDict.contains("2"))
  assert(!LingoDict.contains("@"))
  assert(!LingoDict.contains("testq"))
  assert(!LingoDict.contains("hunvch"))
end

if ARGV[0] == "test"
  test
end