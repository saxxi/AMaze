require "rails_helper"

describe Solver do

  subject { Solver }

  let(:grid) { [
    [0,0,0],
    [0,0,0],
    [0,0,0]
  ] }

  it "#solve! has to be extended" do
    expect{ subject.new(grid).solve! }.to raise_error /extend/i
  end

end
