variable "ami_id" {
  description = "ID of the AMI to use"
  type        = string
  default = "ami-007855ac798b5175e"
}
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  
}
variable "instance_type" {
  description = "Instance type for the instances"
  type        = string
  default = "t2.micro"
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type = list(string)
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type = list(string)
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
  
}
variable "lb_dns" {

}
  
