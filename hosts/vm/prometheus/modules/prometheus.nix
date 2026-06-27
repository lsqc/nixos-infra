{ ... }:

let
  config = import ../../../../common/config.nix;
in
{
  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "dns";
        static_configs = [
          {
            targets = [
              "${config.mkLabFQDN "dns-4"}:9092"
              "${config.mkLabFQDN "dns-5"}:9092"
              "${config.mkLabFQDN "dns-6"}:9092"
            ];
          }
        ];
      }
      {
        job_name = "prometheus";
        static_configs = [ { targets = [ "${config.mkLabFQDN "prometheus"}:9092" ]; } ];
      }
      {
        job_name = "git";
        static_configs = [ { targets = [ "${config.mkLabFQDN "hachi"}:9092" ]; } ];
      }
      {
        job_name = "torrent";
        static_configs = [ { targets = [ "${config.mkLabFQDN "torrent"}:9092" ]; } ];
      }
      {
        job_name = "hydra";
        static_configs = [ { targets = [ "${config.mkLabFQDN "hydra"}:9092" ]; } ];
      }
      {
        job_name = "mastodon";
        static_configs = [ { targets = [ "${config.mkLabFQDN "ash"}:9092" ]; } ];
      }
      {
        job_name = "paperless";
        static_configs = [ { targets = [ "${config.mkLabFQDN "paperless"}:9092" ]; } ];
      }
    ];
  };
}
