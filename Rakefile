$: << __dir__ + '/lib'
require 'bundler/inline'
gemfile do
  gem 'activesupport'
  gem 'rake'
  gem 'duplicate'
  gem 'rspec'
end
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

VALID_NUMBERS = (1..10).to_a + [25, 50, 75, 100]
desc "Solve the numbers game"
task :numbers do
  numbers = target = nil
  loop do
    print "Numbers: " ; numbers = $stdin.gets.chomp.split(/[\D]/).reject(&:blank?).map(&:to_i)
    if numbers.length != 6
      puts "Expected 6 numbers"
    elsif !numbers.all? { |n|  VALID_NUMBERS.include?(n) }
      puts "Invalid numbers"
    else
      break
    end
  end
  loop do
    print "Target: "  ; target = $stdin.gets.chomp.strip.to_i
    if (target < 100) || (target > 999)
      puts "Invalid target"
    else
      break
    end
  end
  puts Numbers::Solver.solutions(target, numbers).unique.first(10)
end

desc "Solve the letters game"
task :letters do
  letters = nil
  loop do
    print "Letters: " ; letters = $stdin.gets.chomp
    (letters.length == 9) or puts "Warning: expected 9 letters"
    break
  end
  puts Letters::Solver.solutions(letters).unique.first(20)
end

desc "Solve any anagram"
task :anagram do
  letters = $stdin.gets.chomp
  puts Letters::Solver.solutions(letters, min_length: letters.length).unique.to_a
end
