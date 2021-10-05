variable "availability_zones" {
  description = "AWS Availability Zones to use (by default will use all available)"
  type        = list(string)
  default     = []
}
