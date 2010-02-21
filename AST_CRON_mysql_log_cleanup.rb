#!/usr/bin/ruby
#Filename: AST_CRON_mysql_log_cleanup.rb
#Description:
# Clean-up all mysql related log files..
#
#Copyright Angelito Manansala License GPL v2
#lito@voicefidelity.net, avmanansala@gmail.com

require ('rubygems')
require ('parseconfig')
require ('active_record')
require ('active_support')

#Parse astguiclient configuration file.
my_config = ParseConfig.new('/etc/astguiclient.conf')
mysql_server_ip = my_config.get_value('VARserver_ip').gsub('>','').strip
mysql_server = my_config.get_value('VARDB_server').gsub('>','').strip 
mysql_database = my_config.get_value('VARDB_database').gsub('>','').strip 
mysql_user = my_config.get_value('VARDB_user').gsub('>','').strip 
mysql_pass = my_config.get_value('VARDB_pass').gsub('>','').strip 
mysql_port = my_config.get_value('VARDB_port').gsub('>','').strip

puts "Mysql server ip is #{mysql_server_ip}\n"

 
ActiveRecord::Base.establish_connection(
:adapter => 'mysql',
:host => mysql_server_ip,
:database => mysql_database,
:username => mysql_user,
:password => mysql_pass
)

#
class Vicidial_agent_log < ActiveRecord::Base 
  set_table_name "vicidial_agent_log"
end
class Vicidial_user_log <  ActiveRecord::Base 
  set_table_name "vicidial_user_log"
end
class Vicidial_admin_log <  ActiveRecord::Base 
  set_table_name "vicidial_admin_log"
end
class Vicidial_log <  ActiveRecord::Base 
  set_table_name "vicidial_log"
end
class Vicidial_call_log <  ActiveRecord::Base 
  set_table_name "call_log"
end


three_months_ago = 1.months.ago.strftime("%Y-%m-%d %H:%M:%S")

puts "Deleting vicidial_agent_log three months old record...\n"
Vicidial_agent_log.delete_all "event_time <= '#{three_months_ago}'"

puts "Deleting vicidial_user_log three months old record...\n"
Vicidial_user_log.delete_all "event_date <= '#{three_months_ago}'"

puts "Deleting vicidial_admin_log three months old record...\n"
Vicidial_admin_log.delete_all "event_date <= '#{three_months_ago}'"

puts "Deleting vicidial_log three months old record...\n"
Vicidial_log.delete_all "call_date <= '#{three_months_ago}'"

puts "Deleting call_log three months old record...\n"
Vicidial_call_log.delete_all "start_time <= '#{three_months_ago}'"

puts
puts "Done...\n"

