p = File.readlines("data/english_words.txt").map(&:chomp).sort
File.write("data/english.txt", p.join("\n"), mode: "a")