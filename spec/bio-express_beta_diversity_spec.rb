require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "BioExpressBetaDiversity" do
  it "should parse a distance matrix" do
    eg = File.expand_path(File.dirname(__FILE__) + '/data/eg.diss')
    d = Bio::EBD::DistanceMatrix.parse_from_file(eg)

    #3
    #4459
    #4446    0.255099
    #4451    0.258384        0.364525
    d.number_of_samples.should == 3
    d.distance_matrix.length.should == 3
    d.distance_matrix[0].should == []
    d.distance_matrix[1].should == [0.255099]
    d.distance_matrix[2].should == [0.258384, 0.364525]
    d.sample_names.should == %w(4459 4446 4451)
    d.distance('4446','4451').should == 0.364525
    d.distance('4451','4446').should == 0.364525
  end
end
