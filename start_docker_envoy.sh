docker run --name=envoy -p 80:10000 -p 7777:7777 --rm \
 -v $(pwd)/local-rate-limit-with-descriptors.yaml:/etc/envoy/envoy.yaml \
 -v $(pwd)/api-routes.yaml:/etc/envoy/api-routes.yaml \
 envoyproxy/envoy:v1.20-latest



#docker run -p 7777:7777 -p 9901:9901 --rm -v=$PWD:/config envoyproxy/envoy:v1.20-latest /usr/local/bin/envoy -c /config/envoy_config.json