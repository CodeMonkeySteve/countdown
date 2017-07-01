$: << __dir__ + '/lib'
require 'active_support'
require 'active_support/core_ext'
$stdout.sync = true

require 'numbers'
require 'letters'

task :numbers do
  print "Numbers: " ; numbers = $stdin.gets.chomp.split(/[,\s]/).reject(&:blank?).map(&:to_i)
  print "Target: "  ; target = $stdin.gets.chomp.strip.to_i
  puts Numbers::Solver.solutions(target, numbers).first(5)
end

task :letters do
  print "Letters: " ; letters = $stdin.gets.chomp
  puts Letters::Solver.solutions(letters).first(10)
end
