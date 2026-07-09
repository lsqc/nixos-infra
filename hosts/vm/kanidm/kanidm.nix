{
  pkgs,
  config,
  ...
}:

let
  cfg = import ../../../common/config.nix;
  certDir = "/var/lib/kanidm/tls";
in
{
  services.kanidm = {
    package = pkgs.kanidmWithSecretProvisioning_1_10;

    server = {
      enable = true;
      settings = {

        domain = "${cfg.domains.services.oauth}";
        origin = "${cfg.oauth.baseUrl}";
        bindaddress = "0.0.0.0:8443";

        tls_chain = "${certDir}/chain.pem";
        tls_key = "${certDir}/key.pem";

        online_backup = {
          path = "/var/lib/kanidm/backups";
          schedule = "00 22 * * *";
          versions = 7;
        };

        log_level = "info";
      };
    };

    client = {
      enable = true;
      settings.uri = "${cfg.oauth.baseUrl}";
    };

    provision = {

      adminPasswordFile = config.age.secrets.kanidm-admin-password.path;
      idmAdminPasswordFile = config.age.secrets.kanidm-idm-admin-password.path;

      enable = true;
      autoRemove = true;
      persons = {
        "lsqc" = {
          displayName = "lsqc";
          mailAddresses = [ "lsqc@nya.vodka" ];
        };
      };

      groups = {
        "forgejo-users" = {
          members = [ "lsqc" ];
        };
        "grafana-users" = {
          members = [ "lsqc" ];
        };
        "grafana-admins" = {
          members = [ "lsqc" ];
        };
      };

      systems.oauth2 = {
        "forgejo" = {
          displayName = "Forgejo";
          imageFile = ../../../assets/forgejo-logo.svg;
          originUrl = "https://git.nya.vodka/user/oauth2/kanidm/callback";
          originLanding = "https://git.nya.vodka/";

          scopeMaps = {
            "forgejo-users" = [
              "openid"
              "email"
              "profile"
            ];
          };
        };

        "grafana" = {
          displayName = "Grafana";
          originUrl = "https://grafana.lab.nya.vodka/login/generic_oauth";
          originLanding = "https://grafana.lab.nya.vodka/";
          scopeMaps = {
            "grafana-users" = [
              "openid"
              "email"
              "profile"
              "groups"
            ];
            "grafana-admins" = [
              "openid"
              "email"
              "profile"
              "groups"
            ];
          };
        };
      };
    };
  };

  systemd.services.kanidm-selfsigned-cert = {
    description = "Generate self-signed TLS cert for Kanidm's internal listener";
    wantedBy = [ "multi-user.target" ];
    before = [ "kanidm.service" ];
    requiredBy = [ "kanidm.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      set -euo pipefail
      mkdir -p ${certDir}
      if [ ! -f ${certDir}/key.pem ]; then
        ${pkgs.openssl}/bin/openssl req -x509 -newkey ec \
          -pkeyopt ec_paramgen_curve:prime256v1 \
          -keyout ${certDir}/key.pem \
          -out ${certDir}/chain.pem \
          -days 3650 -nodes \
          -subj "/CN=${cfg.domains.services.oauth}"
      fi
      chown -R kanidm:kanidm ${certDir}
      chmod 600 ${certDir}/key.pem
      chmod 644 ${certDir}/chain.pem
    '';
  };

  networking.firewall.allowedTCPPorts = [ 8443 ];
}
