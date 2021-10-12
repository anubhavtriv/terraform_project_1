resource "aws_instance" "apache_web" {
  depends_on = [aws_vpc.web_vpc]
  ami = "${var.ami_ids}"
  instance_type = "${var.instance_type}"
  availability_zone = "${var.availability_zone}"
  vpc_security_group_ids = [ "${aws_security_group.web_secgroup.id}" ]
  subnet_id = aws_subnet.web_subnet.id
  associate_public_ip_address = var.associate_public_ip_address
  key_name = "${var.key_name}"
  tags = {
    Name = "${var.instance_name}"
  }
}
resource "aws_ebs_volume" "web_ebs" {
 availability_zone = aws_instance.apache_web.availability_zone
 size = var.size
 tags = {
   Name = "${var.web_ebs_name}"
 }
}

resource "aws_volume_attachment" "ec2_attach" {
 device_name = "${var.device_name}"
 instance_id = aws_instance.apache_web.id
 volume_id  = aws_ebs_volume.web_ebs.id
}
resource "aws_ebs_snapshot" "snapshot" {
  volume_id = aws_ebs_volume.web_ebs.id

  tags = {
    Name = "${var.snapshot_name}"
  }
  
}

resource "null_resource" "web_make" {
  
connection {
	type = "ssh"
	user = "ec2-user"
	private_key = file("/home/anubhav/Downloads/Anubhav.pem")
	host = aws_instance.apache_web.public_ip   
 }
provisioner "remote-exec" {
	inline = [
      "sudo mkfs.ext4 /dev/xvdb",
      "sudo yum install httpd -y",
 	    "sudo systemctl start httpd",
	    "sudo systemctl enable httpd",
      "sudo mount /dev/sdb /var/www/html",
	    "sudo yum install git -y",
 	    "sudo git clone https://github.com/anubhavtriv/index_html_terraform.git  /var/www/html", 
	    "sudo systemctl restart httpd" ,
    ]
 }
}

