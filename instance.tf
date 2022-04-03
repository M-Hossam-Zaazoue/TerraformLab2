
resource "aws_instance" "HossamEC2" {
  ami           = var.ami_id
  instance_type = var.ec2_type
  vpc_security_group_ids = [ aws_security_group.HossamSecGrp.id ]
  key_name = var.key_pair_name

  tags = {
    Name = var.ec2_name
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = file(var.private_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd.service",
    ]
  }
}

output "instance_ip_addr_public" {
  value       = aws_instance.HossamEC2.public_ip
  description = "public IP address of the EC2"
}