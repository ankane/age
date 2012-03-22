require "benchmark"
puts Benchmark.realtime { $names = Marshal.load(File.read("names.dump")) }

module Guess
  ALL_YEARS = 1880..2010

  class << self

    def age_dist(name, years = ALL_YEARS)
      name = name.split.first.downcase

      data = $names[name] || Hash.new(1)

      # Just sum the years we need.
      sum = 0.0
      years.each do |year|
        sum += data[year]
      end

      dist = {}
      years.each do |year|
        dist[year] = data[year] / sum
      end
      dist
    end

    def age(name, years = ALL_YEARS)
      dist = age_dist(name, years)
      best = dist.to_a.sort_by{|v| -1*v[1] }.first
      {:age => best[0], :confidence => best[1]}
    end

  end
end

#puts Guess.age_dist("andrew", 1940..1980)
puts Guess.age("andrew")
