require 'pp'
require 'csv'

module Bio
  class EBD
    # Distance matrix output from express beta diversity (Donovan Parks et al).
    # Similar to phylip distance format, but not quite the same.
    class DistanceMatrix
      attr_accessor :distance_matrix
      attr_accessor :sample_names

      def initialize
        @distance_matrix = []
        @sample_names = []
      end

      def self.parse_from_file(filename)
        ebd = Bio::EBD::DistanceMatrix.new

        line = 1
        expected_number_of_samples = nil
        CSV.foreach(filename, :col_sep => "\t") do |row|
          if line == 1
            # First line is the number of samples
            raise "Parse exception at this row: #{row.inspect}, expected" unless row.length == 1
            expected_number_of_samples = row[0].to_i
          else
            # all other lines are the sample names and then the lower
            # triangular distance matrix
            sample_index = line-2
            raise "Parse exception at this row: #{row.inspect}" unless row.length == sample_index+1
            ebd.sample_names.push row[0]

            distances = row[1...row.length].collect{|d| d.to_f}
            ebd.distance_matrix[sample_index] = distances
          end
          line += 1
        end

        return ebd
      end

      def number_of_samples
        @sample_names.length
      end

      # Return the floating point distance between a pair of samples
      def distance(sample1, sample2)
        index1 = @sample_names.find_index{|n| n==sample1}
        index2 = @sample_names.find_index{|n| n==sample2}
        raise "error extracting the EBD distance between #{sample1.inspect} and #{sample2.inspect}" unless index1 and index2 and index2 != index1
        if index1 > index2
          return @distance_matrix[index1][index2]
        else
          return @distance_matrix[index2][index1]
        end
      end
    end
  end
end
