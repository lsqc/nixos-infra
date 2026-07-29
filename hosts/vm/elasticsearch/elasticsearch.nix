{ ... }:

{
  services.elasticsearch = {
    enable = true;
    dataDir = "/var/lib/elasticsearch";
    extraJavaOptions = [
      "-Djava.net.preferIPv4Stack=true"
      "-Xms16384m"
      "-Xmx16384m"
    ];

    listenAddress = "0.0.0.0";

    port = 9200;
    tcp_port = 9300;
  };
}
