require 'set'

module EnumerableUnique
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

Enumerable.prepend(EnumerableUnique)

