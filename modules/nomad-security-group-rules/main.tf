# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP RULES THAT CONTROL WHAT TRAFFIC CAN GO IN AND OUT OF A NOMAD CLUSTER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group_rule" "allow_http_inbound" {
  type        = "ingress"
  from_port   = "${var.http_port}"
  to_port     = "${var.http_port}"
  protocol    = "tcp"
  cidr_blocks = "${var.allowed_inbound_cidr_blocks}"

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_rpc_inbound" {
  type        = "ingress"
  from_port   = "${var.rpc_port}"
  to_port     = "${var.rpc_port}"
  protocol    = "tcp"
  cidr_blocks = "${var.allowed_inbound_cidr_blocks}"

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_serf_tcp_inbound" {
  type        = "ingress"
  from_port   = "${var.serf_port}"
  to_port     = "${var.serf_port}"
  protocol    = "tcp"
  cidr_blocks = "${var.allowed_inbound_cidr_blocks}"

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_serf_udp_inbound" {
  type        = "ingress"
  from_port   = "${var.serf_port}"
  to_port     = "${var.serf_port}"
  protocol    = "udp"
  cidr_blocks = "${var.allowed_inbound_cidr_blocks}"

  security_group_id = "${var.security_group_id}"
}

resource "aws_security_group_rule" "allow_elasticsearch_rest" {
  type        = "ingress"
  from_port   = "9200"
  to_port     = "9200"
  protocol    = "tcp"
  cidr_blocks = "${var.allowed_inbound_cidr_blocks}"

  security_group_id = "${var.security_group_id}"
}
resource "aws_security_group_rule" "allow_elasticsearch_intra" {
  type        = "ingress"
  from_port   = "9300"
  to_port     = "9300"
  protocol    = "tcp"
  cidr_blocks = "${var.allowed_inbound_cidr_blocks}"

  security_group_id = "${var.security_group_id}"
}
resource "aws_security_group_rule" "allow_kibana" {
  type        = "ingress"
  from_port   = "5601"
  to_port     = "5601"
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${var.security_group_id}"
}
resource "aws_security_group_rule" "allow_beats2logstash" {
  type        = "ingress"
  from_port   = "1704"
  to_port     = "1704"
  protocol    = "tcp"
  cidr_blocks = "${var.allowed_inbound_cidr_blocks}"

  security_group_id = "${var.security_group_id}"
}
