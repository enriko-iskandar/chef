# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "enriko"
client_key               "#{current_dir}/enriko.pem"
validation_client_name   "fugu-validator"
validation_key           "#{current_dir}/fugu-validator.pem"
chef_server_url          "https://api.chef.io/organizations/fugu"
cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_copyright	 "fugu"
cookbook_license	 "apachev2"
cookbook_email		 "enriko@globefish.net"
