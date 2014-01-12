# bio-express_beta_diversity

[![Build Status](https://secure.travis-ci.org/wwood/bioruby-express_beta_diversity.png)](http://travis-ci.org/wwood/bioruby-express_beta_diversity)

Ruby interface to [express beta diversity](https://github.com/dparks1134/ExpressBetaDiversity) things. Currently, functionality is limited to parsing the output distance matrices. 

Note: this software is under active development!

## Installation

```sh
gem install bio-express_beta_diversity
```

## Usage

```ruby
require 'bio-express_beta_diversity'

dists = Bio::EBD::DistanceMatrix.parse_from_file 'Bray-Curtis.cluster.diss'
dists.sample_names #=> ["sample1", "sample2", ... ]
dists.distance('sample1','sample2') #=> 0.251761
dists.distance('sample2','sample1') #=> 0.251761

```

The API doc is online. For more code examples see the test files in
the source tree.
        
## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/wwood/bioruby-express_beta_diversity

## Cite

If you use this software, please cite one of
  
* [BioRuby: bioinformatics software for the Ruby programming language](http://dx.doi.org/10.1093/bioinformatics/btq475)
* [Biogem: an effective tool-based approach for scaling up open source software development in bioinformatics](http://dx.doi.org/10.1093/bioinformatics/bts080)

## Biogems.info

This Biogem is published at (http://biogems.info/index.html#bio-express_beta_diversity)

## Copyright

Copyright (c) 2013 Ben J. Woodcroft. See LICENSE.txt for further details.

