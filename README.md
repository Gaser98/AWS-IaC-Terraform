# AWS-IaC-Terraform
Provided aws infrastructure using hashicorp terraform modules,remote backend and workspaces.
The project aims to provide an insfrastructure capable of redirecting the traffic of internal load balancer that handles traffic of private instances to be accessible through public load balancer . 
I created S3 remote backend to store and backup state files and allowed versioning for better record-keeping,the project is in a specified workspace called dev to  provide isolation for the current project and it's comprised from 4 modules:
1-vpc:
contains vpc,subnets,routes,route tables,internet and NAT gateways and need network associations
2-security_group:
necessary inbound and outbound rules to alow http and ssh traffic
3-loadbalancer:
a)public load balancer for the public instances traffic to enhance performance and increase avalialbility 
b)private load balancer for the private instances traffic 
4-instances:
2 public instances as nginx servers,2 private instances as apache2 servers 
![image](https://github.com/Gaser98/AWS-IaC-Terraform/assets/76227165/953ce0e3-5893-4ddd-b853-1d5b75a0fdf1)
