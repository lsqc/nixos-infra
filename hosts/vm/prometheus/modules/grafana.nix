{ config, ... }:

{
  services.grafana = {
    enable = true;

    settings = {
      security = {
        secret_key = "$__file{${config.age.secrets.grafana-secret-key.path}}";
      };
      server = {
        root_url = "https://grafana.pc.nya.vodka";
        domain = "grafana.pc.nya.vodka";
        http_port = 3000;
        http_addr = "::";

      };
      analytics.reporting_enabled = false;
    };
  };
}
