$: << __dir__ + '/lib'
require 'active_support'
require 'active_support/core_ext'
$stdout.sync = true

require 'numbers'
require 'letters'

require 'set'
module Enumerable
  def unique
    uniq = Set.new
    Enumerator.new do |out|
      self.each do |el|
        if uniq.add?(el)
          out << el
        end
      end
    end.lazy
  end
end

task :numbers do
  print "Numbers: " ; numbers = $stdin.gets.chomp.split(/[,\s]/).reject(&:blank?).map(&:to_i)
  print "Target: "  ; target = $stdin.gets.chomp.strip.to_i
  puts Numbers::Solver.solutions(target, numbers).unique.first(10)
end

task :letters do
  print "Letters: " ; letters = $stdin.gets.chomp
  puts Letters::Solver.solutions(letters).unique.first(20)
end
