variable "project_id" {
  description = "The project to host the cluster in"
  default     = "my-project"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to host the cluster in"
  default     = "us-central1-c"
}

variable "owner" {
  description = "The owner of the cluster"
  default     = "robots"
}

variable "division" {
  description = "The division of the cluster"
  default     = "engineering"
}

variable "org" {
  description = "The organization of the cluster"
  default     = "obs"
}

variable "team" {
  description = "The team of the cluster"
  default     = "observability"
}

variable "project" {
  description = "The project of the cluster"
  default     = "oblt-clusters"
}
