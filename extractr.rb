#!/usr/bin/env ruby
#
# extractr - A simple utility to extract emails and domain names from text
#
# Developer: Mustafa Mohsen <mustafamohsen@tutanota.com>
# Version: 0.2.0
# Licence: BSD 3-Clause
#
 
require 'trollop'
 
def uniqify(text)
        text.map{|i| i.downcase}.uniq.sort
end
 
def extract_domains(data)
        # I use a really loose regex to extract domains and emails, but I think that
        # it is all that needed in most cases
        # uniqify data.scan(/^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}$/)
 
        uniqify((@emails ||= extract_emails data).collect{|e| e.split('@')[1]})
end
 
def extract_emails(data)
        @emails = uniqify data.scan(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b/)
end
 
opts = Trollop::options do
        version "extractr 0.2.0 (c)2015 Mustafa Mohsen"
        banner <<-EOS
extractr - A simple utility to extract emails and domain names from text
 
Usage:
        extractr [options] <filename(s)>
 
Example:
        extractr --extract-emails db_list.csv
        cat *.csv | extractr --extract-domains
 
Options:
EOS
 
        opt :extract_emails, "Extract email addresses", short: "-e"
        opt :extract_domains, "Extract domain names", short: "-d"
        opt :extract_all, "Extract domain names and emails", short: "-a"
end
 
o = Trollop::with_standard_exception_handling opts do
  raise Trollop::HelpNeeded if ARGV.empty? # show help screen
end
 
begin
        data = $<.read
rescue Errno::ENOENT
        puts "No such file"
end
 
if opts[:extract_emails]
        puts extract_emails data
end
 
if opts[:extract_domains]
        puts extract_domains data
end
 
if opts[:extract_all]
        puts extract_emails data
        puts extract_domains data
end
