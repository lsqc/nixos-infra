{ ... }:

let
  config = import ../../../../common/config.nix;
in
{
  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = [
              "${config.mkLabFQDN "dns-4"}:9092"
              "${config.mkLabFQDN "dns-5"}:9092"
              "${config.mkLabFQDN "dns-6"}:9092"
              "${config.mkLabFQDN "prometheus"}:9092"
              "${config.mkLabFQDN "hachi"}:9092"
              "${config.mkLabFQDN "torrent"}:9092"
              "${config.mkLabFQDN "hydra"}:9092"
              "${config.mkLabFQDN "ash"}:9092"
              "${config.mkLabFQDN "paperless"}:9092"
              "${config.mkLabFQDN "elasticsearch"}:9092"
              "${config.mkLabFQDN "kanidm"}:9092"
            ];
          }
        ];
      }
    ];
  };
}
