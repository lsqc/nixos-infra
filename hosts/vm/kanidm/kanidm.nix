{
  pkgs,
  config,
  ...
}:

let
  certDir = "/var/lib/kanidm/tls";
  domain = "id.nya.vodka";
in
{
  services.kanidm = {
    package = pkgs.kanidmWithSecretProvisioning_1_10;

    server = {
      enable = true;
      settings = {
        inherit domain;
        origin = "https://${domain}";

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
      settings.uri = "https://${domain}";
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
          present = true;
        };
      };

      groups = {
        "forgejo-users" = {
          members = [ "lsqc" ];
          present = true;
        };
      };

      systems.oauth2 = {
        "git.nya.vodka" = {
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
          -subj "/CN=${domain}"
      fi
      chown -R kanidm:kanidm ${certDir}
      chmod 600 ${certDir}/key.pem
      chmod 644 ${certDir}/chain.pem
    '';
  };

  networking.firewall.allowedTCPPorts = [ 8443 ];
}
