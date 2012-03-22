require "csv"

#years = 1980..1990
years = 1880..2010
names = {}
years.each do |year|
  CSV.foreach("names/yob#{year}.txt") do |row|
    name = row[0].downcase
    names[name] ||= {}
    names[name][year] = row[2].to_i
  end
end

names.keys.each do |name|
  years.each do |year|
    names[name][year] ||= 1
  end
end

# divide into 26 files based on first name
File.open("names.dump", "w") {|f| f.write(Marshal.dump(names)) }
