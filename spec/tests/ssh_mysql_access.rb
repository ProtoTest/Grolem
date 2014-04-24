require 'net/ssh'

# Requires ssh to allow interactive access with LDAP account
SSH_HOSTNAME="sfo-gate.newokl.com"
SSH_USERNAME="bkitchener"
SSH_PASSWORD="bkitchener123!"

MYSQL_HOST="king-qa02-db01.newokl.com"
MYSQL_PORT=12030
MYSQL_USERNAME="qa02"
MYSQL_PASSWORD="qa02"
MYSQL_DB="king_cart"

def verify_order_in_ax(order_id)
  result = nil

  begin
    Net::SSH.start(SSH_HOSTNAME,
                   SSH_USERNAME,
                   :password => SSH_PASSWORD)  do |ssh_handle|

      query = "select order_id from order_line where order_id=%s;" % order_id

      mysql_cmd = "mysql --user=#{MYSQL_USERNAME} --password=#{MYSQL_PASSWORD} --host=#{MYSQL_HOST} --port=#{MYSQL_PORT}  --database=#{MYSQL_DB} --execute='#{query}' "

      result = ssh_handle.exec(mysql_cmd).to_s
    end

    return result
  rescue Exception => e
    return "Unable to connect to #{SSH_HOSTNAME} using #{SSH_USERNAME}/#{SSH_PASSWORD}: #{e.message}"
  end
end
