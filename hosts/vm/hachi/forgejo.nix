{ lib, config, ... }:

let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  services.forgejo = {
    enable = true;
    database.type = "mysql";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git2.nya.vodka";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = 3000;
        SSH_PORT = lib.head config.services.openssh.ports;
      };
      service = {
        DISABLE_REGISTRATION = false;
      };
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      mailer = {
        ENABLED = true;
        SMTP_ADDR = "mail.nya.vodka";
        FROM = "noreply@${srv.DOMAIN}";
        USER = "noreply@${srv.DOMAIN}";
      };
      migrations = {
        ALLOWED_DOMAINS = "*.nya.vodka";
      };
    };
    secrets = {
      mailer.PASSWD = config.age.secrets.forgejo-mailer-password.path;
    };
  };

  age.secrets.forgejo-mailer-password = {
    file = ../../../secrets/forgejo-mailer-password.age;
    mode = "400";
    owner = "forgejo";
  };
}
