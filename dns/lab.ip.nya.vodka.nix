{
  SOA = {
    nameServer = "dns4.lab.ip.nya.vodka.";
    adminEmail = "admin.nya.vodka.";
    serial = -1;
    refresh = 3600;
    retry = 1800;
    expire = 604800;
    ttl = 86400;
  };

  TTL = 3600;

  NS = [
    "dns1.lab.ip.nya.vodka."
    "dns2.lab.ip.nya.vodka."
    "dns3.lab.ip.nya.vodka."
    "dns4.lab.ip.nya.vodka."
    "dns5.lab.ip.nya.vodka."
    "dns6.lab.ip.nya.vodka."
  ];

  subdomains = {
    # legacy
    opnsense = {
      A = [ "10.42.0.1" ];
    };
    dns-1 = {
      A = [ "10.42.0.2" ];
    };
    dns-2 = {
      A = [ "10.42.0.3" ];
    };
    dns-3 = {
      A = [ "10.42.0.4" ];
    };
    dns-4 = {
      A = [ "10.42.0.5" ];
    };
    dns-5 = {
      A = [ "10.42.0.6" ];
    };
    dns-6 = {
      A = [ "10.42.0.7" ];
    };
    pxe = {
      A = [ "10.42.0.8" ];
    };
    mtk = {
      A = [ "10.42.0.10" ];
    };
    vpn1 = {
      A = [ "10.42.0.19" ];
    };
    vpn2 = {
      A = [ "10.42.0.20" ];
    };
    # NOTE: db1 appeared twice with different IPs in the source zone
    # (10.42.0.21 and 10.42.0.99) — merged into one multi-value A record.
    db1 = {
      A = [
        "10.42.0.21"
        "10.42.0.99"
      ];
    };
    db2 = {
      A = [ "10.42.0.22" ];
    };
    db3 = {
      A = [ "10.42.0.23" ];
    };
    docker-1 = {
      A = [ "10.42.0.31" ];
    };
    docker-2 = {
      A = [ "10.42.0.32" ];
    };
    mc-prod = {
      A = [ "10.42.0.40" ];
    };
    mc-test = {
      A = [ "10.42.0.41" ];
    };
    postgres = {
      A = [ "10.42.0.50" ];
    };
    immich = {
      A = [ "10.42.0.55" ];
    };
    forgejo = {
      A = [ "10.42.0.64" ];
    };
    hachi = {
      A = [ "10.42.0.66" ];
    };
    ntfy = {
      A = [ "10.42.0.67" ];
    };
    jellyfin = {
      A = [ "10.42.0.70" ];
    };
    prometheus = {
      A = [ "10.42.0.72" ];
    };
    ash = {
      A = [ "10.42.0.73" ];
    };
    kanidm = {
      A = [ "10.42.0.77" ];
    };
    hydra = {
      A = [ "10.42.0.103" ];
    };
    pbx = {
      A = [ "10.42.0.198" ];
    };
    paperless = {
      A = [ "10.42.0.213" ];
    };

    router = {
      AAAA = [ "fd00:420:1::1" ];
    };
    cerberus = {
      AAAA = [ "fd00:420:2::1" ];
    };
    mtk-core = {
      AAAA = [ "fd00:420:1:1::2" ];
    };
    pve-alpha = {
      AAAA = [ "fd00:420:1::a" ];
    };
    pve-beta = {
      AAAA = [ "fd00:420:1::b" ];
    };
    pve-gamma = {
      AAAA = [ "fd00:420:1::c" ];
    };
    pve-delta = {
      AAAA = [ "fd00:420:1::d" ];
    };
    pve-c240 = {
      AAAA = [ "fd00:420:1::c240" ];
    };

    dns1 = {
      AAAA = [ "fd00:420:1:d::1" ];
    };
    dns2 = {
      AAAA = [ "fd00:420:1:d::2" ];
    };
    dns3 = {
      AAAA = [ "fd00:420:1:d::3" ];
    };
    dns4 = {
      AAAA = [ "fd00:420:1:d::4" ];
    };
    dns5 = {
      AAAA = [ "fd00:420:1:d::5" ];
    };
    dns6 = {
      AAAA = [ "fd00:420:1:d::6" ];
    };

    vpn1 = {
      AAAA = [ "fd00:420:1:45::1" ];
    };
    vpn2 = {
      AAAA = [ "fd00:420:1:45::2" ];
    };
    forgejo = {
      AAAA = [ "fd00:420:1:ff::1" ];
    };
    forgejo-nix = {
      AAAA = [ "fd00:420:1:ff::2" ];
    };
    docker1 = {
      AAAA = [ "fd00:420:1:dc::1" ];
    };
    docker2 = {
      AAAA = [ "fd00:420:1:dc::2" ];
    };
    kanidm = {
      AAAA = [ "fd00:420:1:1d::1" ];
    };
    db1 = {
      AAAA = [ "fd00:420:1:db::1" ];
    };
    db2 = {
      AAAA = [ "fd00:420:1:db::2" ];
    };
    db3 = {
      AAAA = [ "fd00:420:1:db::3" ];
    };
    mc-prod = {
      AAAA = [ "fd00:420:1:1::40" ];
    };
    mc-test = {
      AAAA = [ "fd00:420:1:1::41" ];
    };
    prometheus = {
      AAAA = [ "fd00:420:1:e::1" ];
    };

    legacy-influxdb = {
      CNAME = "docker1.lab.ip.nya.vodka.";
    };
    legacy-grafana = {
      CNAME = "docker1.lab.ip.nya.vodka.";
    };
  };
}
