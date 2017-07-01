require 'spec_helper'
require 'numbers'

include Numbers

describe Expression do
  it "#initialize" do
    expect(Expr(2,:+,3)).to eq Expr(:+,2,3)
  end
end

describe Solver do
  it "solves with simple equality" do
    expect(Solver.solutions(2, [999, 1, 2, 9999])).to eq [2]
  end

  it "solves with simple addition" do
    expect(Solver.solutions(9, [999, 7, 2, 9999])).to eq [Expr(7,:+,2)]
  end

  it "solves with simple subtraction" do
    expect(Solver.solutions(4, [999, 7, 3, 9999])).to eq [Expr(7,:-,3)]
    expect(Solver.solutions(4, [999, 3, 7, 9999])).to eq [Expr(7,:-,3)]
  end

  it "solves with simple multiplication" do
    expect(Solver.solutions(21, [999, 7, 3, 9999])).to eq [Expr(7,:*,3)]
  end

  it "solves with simple division" do
    expect(Solver.solutions(3, [999, 2, 6, 9999])).to eq [Expr(6,:/,2)]
    expect(Solver.solutions(3, [999, 6, 2, 9999])).to eq [Expr(6,:/,2)]
  end

  it "solves with addition and multiplication" do
    expect(Solver.solutions(19, [999, 3, 4, 7, 9999])).to eq [Expr( Expr(3,:*,4), :+,7 )]
  end

  it "solves complex examples" do

  end
end