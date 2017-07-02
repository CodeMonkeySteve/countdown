require 'set'

module Letters
  class Solver
    def self.solutions(letters)
      new(letters).solutions
    end

    def initialize(letters)
      letters = letters.split('')  if letters.is_a?(String)
      @letters = letters.reject(&:blank?).map(&:downcase)
    end

    def solutions
      Enumerator.new do |out|
        @letters.length.downto(1).each do |len|
          @letters.permutation(len).each do |w|
            word = w.join('')
            out << word  if words.include?(word)
          end
        end
      end.lazy
    end

  private

    def words
      @words ||= begin
        words = Set.new
        File.open(__dir__+'/../words.txt').each_line { |w|  words.add(w.chomp.downcase) }
        words
      end
    end
  end
end



