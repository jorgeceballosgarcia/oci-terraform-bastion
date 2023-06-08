resource "oci_bastion_bastion" "bastion" {

  bastion_type     = "STANDARD"
  compartment_id   = var.compartment_ocid
  target_subnet_id = var.subnet_vcn_ocid
  dns_proxy_status = "ENABLED"

  client_cidr_block_allow_list = [
    "0.0.0.0/0"
  ]
  name = "${var.bastion_name}-bastion"
  
}

resource "oci_bastion_session" "oci_bastion_session" {

  bastion_id = oci_bastion_bastion.bastion.id
  key_details {
    public_key_content = file(var.ssh_public_key_path)
  }
  target_resource_details {
    session_type       = "DYNAMIC_PORT_FORWARDING"
  }
  session_ttl_in_seconds = 10800
  display_name = "${var.bastion_name}-bastion-session-socks5"
}


output "connection_details" {
  value = <<EOF
  
  Bastion Proxy Socks5: ${replace(oci_bastion_session.oci_bastion_session.ssh_metadata.command, "ssh -i <privateKey> -N -D 127.0.0.1:<localPort> -p 22", "ssh -i bastion.key -N -D 127.0.0.1:22022 -p 22")} 

EOF
}