action :start_master do

  bash "start-master" do
    user node[:spark][:user]
    group node[:spark][:group]
    code <<-EOF
     #{node[:spark][:home]}/sbin/start-master.sh
    EOF
  end
 
end


action :start_slave do

  bash "start-slave" do
    user node[:spark][:user]
    group node[:spark][:group]
    code <<-EOF
    set -e

    cd #{node[:spark][:home]}    
    ./sbin/start-slave.sh --properties-file conf/spark-defaults.conf

# spark 1.4 here
#    ./sbin/start-slave.sh #{new_resource.master_url}
# Older spark here
#    #./sbin/start-slave.sh #{new_resource.slave_id} #{new_resource.master_url}
    EOF
#    not_if "#{node[:spark][:home]}/sbin/start-slave.sh --properties-file #{node[:spark][:home]}/conf/spark-defaults.conf | grep \"stop it first\""
    not_if "jps | grep \"Worker\""
  end
 
end
