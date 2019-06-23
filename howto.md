on your local machine, install:

packer
terraform
ansible
git

have an aws account, put credentials

clone repo, build image
prepare env file, source it
terraform init, terraform plan, terraform apply

edit ansible.cfg, install docker with ansible
ssh to a node, nomad run
elasticsearch will be dead, sadly 

1 - build ami (packer)
2 - build nomad/consul cluster (terraform)
3 - populate inventori.ini (aws cli)
3 - assign client nodes to node_class (manual / ansible)
4 - bring this into a 


