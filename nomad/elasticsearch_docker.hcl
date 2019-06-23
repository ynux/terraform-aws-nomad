job "elasticsearch_docker" {
  datacenters = ["eu-central-1a","eu-central-1b","eu-central-1c"]
  group "elasticsearch-group-docker" {
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

    task "run-elasticsearch-docker" {
      driver = "docker"

      config {
        image = "docker.elastic.co/elasticsearch/elasticsearch:7.1.1"
        network_mode = "host"

        port_map {
          elasticsearch_rest = 9200
          elasticsearch_intra = 9300
        }
      }

      template {
        change_mode = "noop"
        destination = "config/unicast_hosts.txt"
        data = <<EOF
    {{ range service "intra-elasticsearch-docker|any" }}{{ .Address }}:{{ .Port }}
    {{ end }}
        EOF
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
        name = "rest-elasticsearch-docker"
        port = "elasticsearch_rest"
        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout = "5s"
        }
      }

      service {
        name = "intra-elasticsearch-docker"
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


