variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"  # Optional default
}

variable "name" {
  description = "k8_vpc"
  type        = string
  default     = "myapp"  
}
