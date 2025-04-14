# Analyzes the lingo puzzles to determine their fairness.
# English dictionary taken from https://github.com/dwyl/english-words.

require 'lingo_dict'

def analyze_blue_middle(clue, answer)
  # Text replacement mechanic from clue to answer. Returns a 
  # dictionary.
  # 
  # Report Output:
  #   - Fairness Rating: Gives a percentage of if the puzzle
  #     is fair or not based on the ratio between the number
  #     of letters in the clue to the number of letters in the
  #     answer and if the substring added is continuous. Gives
  #     a 0% if the change from the clue to answer is invalid.
  #   - Addition Ratio: A percentage from dividing the number
  #     of letters from the clue to the number of letters from
  #     the answer.
  #   - Broken Added Substring: A boolean value if a continuous
  #     substring is added to the blue.
  #   - Validity: A string value if both the clue and answer are
  #     valid words and the substring of clue is in answer. 
  #   - Other Answers: A list of all other possible answers 
  #     excluding the answer from the parameter.
  addition_ratio = clue.length.to_f / answer.length.to_f * 100.0
  is_continuous = _contains_substring(clue, answer)
  is_valid = "1234567890qwertyuiopasdfghjklzxcvbnm!@#$%^&*()(QWERTYUIOPASDFGHJKLZXCVBNM)"      #TODO
  other_answers = []
  fairness_rating = is_valid ? addition_ratio * (is_continuous ? 0.65 : 1.0) * (1 - other_answers.length.to_f * 0.1) : 0.0
  return {
    "Clue" => clue,
    "Answer" => answer,
    "Fairness Rating" => "%.2f%%" % fairness_rating,
    "Addition Ratio" => "%.2f%%" % addition_ratio,
    "Broken Added String" => is_continuous.to_s,
    "Validity" => is_valid,
    "Other Answers" => other_answers.to_s
  }
end

def analyze_purple_middle(clue, answer)
  # 
  # Report Output:
  #   - Fairness Rating: Gives a percentage of if the puzzle
  #     is fair or not. A high fairness rating from the clue 
  #     answer input comes from how many letters from the clue
  #     is replaced, how many letters are added or removed as 
  #     replacement, and checks if the substring between both 
  #     is continuous. Gives a 0% if the change from clue to
  #     answer is the same as the other mechanics or is invalid. 
  #   - 
  #   - 
  #   - 
  return
end

def analyze_orange_middle(clue, answer, cipher)
  cipher = (cipher || "wanderlust").lower
  
end

def is_valid_white_middle(clue, answer)
  # Returns true if the clue and answer are equivalent.
  return clue == answer
end

def is_valid_black_middle(clue, answer)
  # Returns true if the reverse of the clue and answer are
  # equivalent.
  return clue.reverse == answer
end

def is_valid_red_middle(clue, answer)
  # Returns true if the answer is a substring of the clue.
  return
end

def is_valid_blue_middle(clue, answer)
  # Returns true if the clue is a substring of the answer.
  return
end

def is_valid_yellow_middle(clue, answer)
  # Returns true if the letter frequency in the clue is
  # equivalent to the letter frequency in the answer.
  return
end

def is_valid_purple_middle(clue, answer)
  # Returns true if the clue has a letter the answer has.
  return
end

def is_valid_brown_middle(clue, answer)
  # Returns true if the clue-answer pair exists in the brown
  # middle file.
  return
end

def is_valid_gray(clue, answer)
  # Returns true if the clue-answer pair exists in the gray
  # file.
  return
end

def is_valid_mint_middle(clue, answer, reference)
  # Returns true if puzzle is referencing a previous puzzle.
  # The reference parameter is used to check if the puzzle exists
  # in any level in Lingo 1 or from history.
  case reference
  when "level1"
    return
  when "level2"
    return
  when "library"
    return
  when "pumpkinpatch"
    return
  when "dreamscape"
    return
  else
    puts "Reference value is invalid."
  end
end

def _longest_common_substring(w1, w2)
  # Returns the longest common substring between two strings.
  table = Array.new(w1.length + 1) {Array.new(w2.length + 1)}
  0.upto(w1.length + 1) do |r|
    0.upto(w2.length + 1) do |c|
      if r == 0 || c == 0
        table[r][c] = 0
      elsif w1[r] == w2[c]
        table[r][c] = [table[r-1][c], table[r][c-1]].max
      end
    end
  end
end

def _contains_substring(string, target)
  i = 0
  string.each_char() do |c|
    if c == target[i] 
      i += 1
    end
  end
  return target[i] != nil
end

def _is_word(word)
  # TODO
  return true
end

def get_analytics_as_string(title, analytics)
  lines = []
  analytics.each do |attribute, value|
    lines += [attribute + ": " + value.to_s]
  end
  print(_format_to_box(title, lines))
end

def _format_to_box(title, lines)
  inner_width = title.length
  thickbar = "|" + "=" * (inner_width + 2) + "|\n"
  thinbar = "|" + "-" * (inner_width + 2) + "|\n"
  fill = lambda do |s| return s + " " * (inner_width - s.length) end
  formatted_box = thickbar + _pad_ends_with_piped_spaces(title) + thinbar
  _break_up_text(lines, inner_width).each do |line| 
    formatted_box += _pad_ends_with_piped_spaces(fill[line]) 
  end
  formatted_box += thickbar
  return formatted_box
end

def _break_up_text(lines, width)
  new_lines = []
  lines.each do |line| 
    current = line
    while current.length > width
      new_lines += [current[0...width]]
      current = current[0...width]
      print(current)
    end
    print(current)
    new_lines += [current]
  end
  return new_lines
end

def _pad_ends_with_piped_spaces(line)
  return "| " + line + " |\n"
end

if ARGV.length < 4
  puts "Use case: ruby lingo_analyzer.rb [color] [top|middle|bottom] [clue] [answer]"
  exit
end

color = ARGV[0].downcase
height = ARGV[1].downcase
clue = ARGV[2].downcase
answer = ARGV[3].downcase
cipher = ARGV[4] && ARGV[4].downcase

case color + " " + height
when "white middle"
  puts get_analytics_as_string("White Middle Analytics Description", analyze_white_middle(clue, answer))
when "black middle"
  puts get_analytics_as_string("Black Middle Analytics Description", analyze_black_middle(clue, answer))
when "red middle"
  puts get_analytics_as_string("Red Middle Analytics Description", analyze_red_middle(clue, answer))
when "blue middle"
  puts get_analytics_as_string("Blue Middle Analytics Description", analyze_blue_middle(clue, answer)) 
when "yellow middle"
  puts get_analytics_as_string("Yellow Middle Analytics Description", analyze_yellow_middle(clue, answer))
when "purple middle"
  puts get_analytics_as_string("Purple Middle Analytics Description", analyze_purple_middle(clue, answer))
when "orange middle"
  puts get_analytics_as_string("Orange Middle Analytics Description", analyze_orange_middle(clue, answer, cipher))
else
  puts "Use case: ruby lingo_analyzer.rb [color] [top|middle|bottom] [clue] [answer]"
end