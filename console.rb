$:.unshift Dir.pwd
require 'node.rb'
require 'field.rb'

Field.createboard 5,5
start = Field.new 0,0
target = Field.new 4,4
puts "START: #{start}"
puts "TARGET: #{target}"

algos = Hash.new
algos["breadth first"] = lambda{|target| start.breadth_first target}
algos["breadth first minimal cost"] = lambda{|target| start.breadth_first_minimal_cost target}
algos["depth first"] = lambda{|target| start.depth_first target}
algos["depth first limit"] = lambda{|target| start.depth_first_limit target}
algos["hillclimbing"] = lambda{|target| start.hillclimbing target}
algos["hillclimbing backtracking"] = lambda{|target| start.hillclimbing_backtracking target}
algos["best first"] = lambda{|target| start.best_first target}
algos["a-algo"] = lambda{|target| start.a_algo target}

algos.each do |name,funktion| 
  puts "#### #{name} ####"
  start_time = Time.new
  result = funktion.call target
  finish_time = Time.new
  puts "Time: #{finish_time - start_time}"
  puts "Path: #{result.path.to_s}"
  puts "Lenght: #{result.path.size.to_s}"
  puts "Cost: #{result.path_cost}"
end