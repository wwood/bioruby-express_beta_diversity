require 'csv'

# Express Beta Diversity input "OTU table" format parser.
class Bio::EBD::Format
  attr_accessor :otu_names

  # Hash of sample names to array of counts. The counts
  # are floats that correspond to the otu_names.
  attr_accessor :sample_counts

  def initialize
    @sample_counts = {}
    @otu_names = []
  end

  def self.parse_from_file(filename)
    ebd = Bio::EBD::Format.new

    #        100535  1008038
    # sample1    5.0       0
    # sample2    0       1.0
    first_line = true
    CSV.foreach(filename, :col_sep => "\t") do |row|
      if first_line
        # First line is the IDs of the OTUs
        raise "EBD format file appears to be incorrectly formatted on the first line: #{row.inspect}" if row.length < 2
        ebd.otu_names = row[1...row.length]
        first_line = false
      else
        next if row.empty? #Ignore empty lines

        # all other lines are the sample names and then number of observations of the OTUs
        raise "Parse exception at this row: #{row.inspect}" unless row.length == ebd.otu_names.length+1

        sample_name = row[0]
        raise "Duplicate sample name detected in EBD format: #{row[0]}" if ebd.sample_counts.key?(sample_name)

        ebd.sample_counts[sample_name] = row[1...row.length].collect{|count| count.to_f}
      end
    end

    return ebd
  end

  def number_of_samples
    @sample_counts.length
  end
end
