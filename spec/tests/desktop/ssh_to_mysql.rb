require 'net/ssh'
require 'mysql2'

SSH_HOSTNAME="sfo-gate.newokl.com"
SSH_USERNAME="bkitchener"
SSH_PASSWORD="bkitchener123!"

MYSQL_HOST="king-qa02-db01.newokl.com"
MYSQL_PORT=12030
MYSQL_USERNAME="qa02"
MYSQL_PASSWORD="qa02"
MYSQL_DB="king_cart"

begin
  Net::SSH.start(SSH_HOSTNAME,
                          SSH_USERNAME,
                         :password => SSH_PASSWORD)  do |ssh_handle|

    query = "select * from cart;"

     mysql_cmd = "mysql --user=#{MYSQL_USERNAME} --password=#{MYSQL_PASSWORD} --host=#{MYSQL_HOST} --port=#{MYSQL_PORT}  --database=#{MYSQL_DB} --execute='#{query}' "


     puts ssh_handle.exec!('ruby -v')
     puts ssh_handle.exec(mysql_cmd)

  end

rescue Exception => e
  puts "Unable to connect to #{SSH_HOSTNAME} using #{SSH_USERNAME}/#{SSH_PASSWORD}: #{e.message}"
end
