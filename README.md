# extractr
extractr is simple utility to extract emails and domain names from text. I have taken quick-and-dirty-but-effective approach, not perfect in any means

## Download and Installation

Clone the repository, or simply just download extractr.rb. It requires Trollop gem. Use `gem install trollop` to install it

## Usage

	extractr [options] <filename(s)>

	Options:
	  -e, --extract-emails     Extract email addresses
	  -d, --extract-domains    Extract domain names
	  -a, --extract-all        Extract domain names and emails
	  -v, --version            Print version and exit
	  -h, --help               Show this message

### Examples

	extractr --extract-emails db_list.csv
	cat *.csv | extractr.rb --extract-domains
 
