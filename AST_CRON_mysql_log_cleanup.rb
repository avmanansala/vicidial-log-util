#!/usr/bin/ruby
#Filename: AST_CRON_mysql_log_cleanup.rb
#Description:
# Clean-up all mysql related log files..
#
#Copyright Angelito Manansala License GPL v2
#lito@voicefidelity.net, avmanansala@gmail.com

require ('rubygems')
require ('parseconfig')
require ('mysql')
require ('active_record')


#Parse astguiclient configuration file.
my_config = ParseConfig.new('/etc/astguiclient.conf')
mysql_server_ip = my_config.get_value('VARserver_ip').gsub('>','').strip
mysql_server = my_config.get_value('VARDB_server').gsub('>','').strip 
mysql_database = my_config.get_value('VARDB_database').gsub('>','').strip 
mysql_user = my_config.get_value('VARDB_user').gsub('>','').strip 
mysql_pass = my_config.get_value('VARDB_pass').gsub('>','').strip 
mysql_port = my_config.get_value('VARDB_port').gsub('>','').strip

puts "Mysql server ip is #{mysql_server_ip}"

 
ActiveRecord::Base.establish_connection(
:adapter => 'mysql',
:host => mysql_server_ip,
:database => mysql_database,
:user => mysql_user,
:password => mysql_pass
)

#
class Phones < ActiveRecord::Base
end

phones = Phones.find(:first)
#puts "the first campaign is #{campaign_first}"


