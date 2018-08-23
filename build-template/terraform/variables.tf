variable "tag" {
  description = "The Network resources are being fetched using the Tag"
  default     = "test-2"
}

variable "pg_memory" {
  description = "Memory for Postgres Container"
  default     = "512"
}

variable "pg_cpu" {
  description = "CPU for Postgres Container"
  default     = "512"
}

variable "redis_memory" {
  description = "Memory for Redis Container"
  default     = "512"
}

variable "redis_cpu" {
  description = "CPU for Redis Container"
  default     = "512"
}
