job "curator" {
  datacenters = ["eu-central-1a","eu-central-1b","eu-central-1c"]

  constraint {
    attribute = "node_class"
    value     = "docker_driver"
  }

  type = "batch"

  periodic {
    cron             = "41 3 * * * *"
    prohibit_overlap = true
    time_zone        = "UTC"
  }

  task "run-curator" {
    driver = "docker"

    config {
      image      = ""
      entrypoint = ["curator", "--config", "/config/curator.yml", "/config/action.yml"]

      volumes = [
        "/opt/curator/config:/config:ro",
      ]
    }

    resources {
      cpu    = 250
      memory = 256
    }
  }
}
