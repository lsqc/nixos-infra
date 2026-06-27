rec {
  domains = {
    lab = "lab.ip.nya.vodka";
    hz = "hz.ip.nya.vodka";
  };

  networks = {
    lab = [ "fd00:420:1::/48" ];
    hz = [
      "fd00:420:2::/48"
      "fd00:420:3::/48"
      "fd00:420:99::/48"
    ];
  };

  mkLabFQDN = host: "${host}.${domains.lab}";
  mkHzFQDN = host: "${host}.${domains.hz}";
}
