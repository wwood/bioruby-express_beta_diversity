require 'tempfile'
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


describe 'ebd format parser' do
  it 'should parse somethign simple' do

    Tempfile.open('test_ebd') do |t|
      t.print "\t"
      t.puts %w(100535  1008038).join "\t"
      t.puts %w(sample1 5.0  0.0).join "\t"
      t.puts %w(sample2 0.0  1.0).join "\t"
      t.close

      ebd = Bio::EBD::Format.parse_from_file t.path
      ebd.otu_names.should == %w(100535  1008038)
      ebd.sample_counts.should == {
        'sample1' => [5.0,0.0],
        'sample2' => [0.0,1.0],
        }
    end
  end
end