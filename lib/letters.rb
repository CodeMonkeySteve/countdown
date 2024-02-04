require 'set'

module Letters
  class Solver
    def self.solutions(letters, **opts)
      new(letters).solutions(**opts)
    end

    def initialize(letters)
      letters = letters.split('')  if letters.is_a?(String)
      @letters = letters.reject(&:blank?).map(&:downcase)
    end

    def solutions(min_length: 1)
      Enumerator.new do |out|
        @letters.length.downto(min_length).each do |len|
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



