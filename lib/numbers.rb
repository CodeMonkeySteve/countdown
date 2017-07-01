require 'duplicate'

module Numbers
  def Expr(*args, **opts) ; Expression.new(*args, **opts) ; end
  class Expression
    OPS = %i(+ - * /).freeze
    attr_reader :op, :a, :b

    def initialize(op = nil, a = nil, b = nil, parent: nil)
      if a.is_a?(Symbol)
        @op, @a = a, op
      else
        @op, @a = op, a
      end
      @b = b
      @parent = parent
      @value = nil
    end

    def ==(that)
      (self.class == that.class) && (@op == that.op) && (
        ((@a == that.a) && (@b == that.b)) ||
        (%i(+ *).include?(@op) && (@a == that.b) && (@b == that.a))
      )
    end

    def valid?
      @op && @a && @b && (a = @a.to_i).nonzero? && (b = @b.to_i).nonzero? && case @op
        when :+ then (a >= b)
        when :* then (a >= b) && (b > 1)
        when :- then a > b
        when :/ then (a >= b) && (b > 1) && (a % b) == 0
        else    false
      end
    end

    def inspect
      a = @a.is_a?(Expression) ? "(#{@a.inspect})" : @a.inspect
      b = @b.is_a?(Expression) ? "(#{@b.inspect})" : @b.inspect
      "#{a} #{@op} #{b}"
    end
    alias :to_s :inspect

    %i(op a b).each do |attr|
      define_method("#{attr}=") do |val|
        expire_cache
        instance_variable_set("@#{attr}", val)
      end
    end

    def to_i
      @value ||= @a.to_i.send(@op, @b.to_i)
    end

  protected

    def expire_cache
      @value = nil
      @parent&.expire_cache
    end
  end

  class Solver
    def self.solutions(target, numbers)
      new(target, numbers).solutions
    end

    def initialize(target, numbers)
      @target = target
      @numbers = numbers
      @expr = nil
    end

    def solutions
      Enumerator.new do |out|
        (1..@numbers.length).each do |n|
          @numbers.permutation(n) do |nums|
            permute(nums).each do |expr|
              if expr.to_i == @target
                out << Duplicate.duplicate(expr)
              end
            end
          end
        end
      end.lazy
    end

private

    def permute(numbers, parent: nil)
      Enumerator.new do |out|
        if numbers.length == 1
          out << numbers[0]

        elsif numbers.length == 2
          expr = Expression.new(nil, *numbers, parent: parent)
          Expression::OPS.each do |op|
            expr.op = op
            out << expr  if expr.valid?
          end

        else
          expr = Expression.new(parent: parent)
          (1...numbers.length).each do |i|
            permute(numbers[0...i], parent: parent).each do |a|
              expr.a = a

              permute(numbers[i..-1], parent: parent).each do |b|
                expr.b = b

                Expression::OPS.each do |op|
                  expr.op = op
                  out << expr  if expr.valid?
                end
              end
            end
          end
        end
      end.lazy
    end
  end
end
