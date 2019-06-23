job "elasticsearch_java" {
  datacenters = ["eu-central-1a","eu-central-1b","eu-central-1c"]
  group "elasticsearch-group-java" {
    count = 3
    restart {
      attempts = 3
      delay    = "30s"
      interval = "30m"
      mode = "delay"
    }

    reschedule {
      attempts  = 0
      unlimited = false
    }

    task "run-elasticsearch-java" {
      driver = "java"

        port_map {
          elasticsearch_rest = 9200
          elasticsearch_intra = 9300
        }
      }

      env {
        "cluster.name" = "search-meetup-munich"
        "network.bind_host"                  = "0.0.0.0"
        "network.publish_host"               = "${NOMAD_IP_elasticsearch_intra}"
        "discovery.zen.hosts_provider"       = "file"
        "discovery.zen.minimum_master_nodes" = 2
        "xpack.security.enabled"             = "false"
        "xpack.ml.enabled"                   = "false"
        "xpack.graph.enabled"                = "false"
        "xpack.watcher.enabled"              = "false"
        "searchguard.enterprise_modules_enabled" = "false"
      }

      resources {
        cpu = 50	
        memory = 512
        network {
          mbits = 50
          port "elasticsearch_rest" { static = 9200 }
          port "elasticsearch_intra" { static = 9300 }
        }
      }

      service {
        name = "rest-elasticsearch"
        port = "elasticsearch_rest"
        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout = "5s"
        }
      }

      service {
        name = "intra-elasticsearch"
        port = "elasticsearch_intra"
        check {
          type = "tcp"
          interval = "10s"
          timeout = "5s"
        }
      }
    }
  }
}


