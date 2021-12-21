# Demonstrates rate-limiting of service API end points using envoy proxy.

## Requires
1. Local docker 
2. Python for starting http service
3. JMeter for load testing rate-limiting


## Run
1. Run start_http_server.sh
   i. Start http service in local host running on port 8000

2. Run start_docker_envoy.sh
     i. Starts envoy proxy in docker container
    ii. Command line arg -p : 80 localhost port is mapped to port 10000 in envoy.
   iii. Command line arg -v : local envoy files are mapped to file-paths in docker container that would be used by envoy runtime.
  iiii. envoyproxy/envoy:v1.20-latest : version of envoy docker would pull from github.

3. Launch Apache Jmeter
   - In Test Plan, add Thread Group
       - In Thread Group set Number of Threads as 10, Ramp-up as 1 and Loop Count as 10
   - In Thread Group Add, Http Requests Defaults, Summary Report, Http Request
   - In Http Request Defaults
       - Server Name or IP: Localhost
       - Port : 80
       - Path : /foo/bar
   - In Http Request add View Results Tree


4. Play Jmeter
   i. In View Results Tree, some of the HTTP requests should fail
   ii. In Response headers, there should be: HTTP/1.1 429 Too Many Requests


## Details

1. Request to http://localhost would be delegated (docker port mapping) to envoy proxy that is listening on 10000 port. 
   a. Envoy proxy is configured to listen on 10000 port. In static_resources check listeners config.
2. The HTTP connection manager in the envoy proxy YAML file references cluster - service_protected_by_rate_limit.
3. The cluster service_protected_by_rate_limit is mapped to forward the request to http service running in local docker at 8000 port.
