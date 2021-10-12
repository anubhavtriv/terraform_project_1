#*********************************************** Providers **************************************

variable "aws_region" {
    default = "ap-south-1"
}

#********************************************** VPC Variable *********************************************************

variable "secgroup_name" {
    default = "web"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    default =  "10.0.1.0/24"    
}

variable "vpc_tag_name" {
    default = "web_vpc"
}

variable "igw_tag_name" {
    default = "web_igw"
}

variable "web_subnet_tag_name" {
    default = "web_subnet"
}

variable "web_rt_name_tag" {
    default = "web_rt"
}
variable "secgroup_description" {
    default = "Allow TLS inbound traffic"
}

#********************************************** EC2 Variables *******************************************************

variable "instance_type" {
    default = "t2.micro"
}

variable "instance_name" {
    default = "apache_web_server"
}
variable "associate_public_ip_address" {
       type = bool       
    default = true
}

variable "availability_zone"{
    default = "ap-south-1a"
}

variable "key_name" {
    default = "Anubhav"
}

variable "ami_ids" {
    default = "ami-0a23ccb2cdd9286bb"
}

#************************************************ EBS Variables ****************************************

variable "web_ebs_name" {
    default = "web_ebs"
}

variable "size" {
    default = 8
}

variable "device_name" {
    default = "/dev/sdb"
}

#************************************************ Snapshot ****************************************

variable "snapshot_name" {
    default = "web_snapshot"
}

