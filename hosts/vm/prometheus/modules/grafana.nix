{ config, ... }:

let
  cfg = import ../../../../common/config.nix;
in
{
  services.grafana = {
    enable = true;

    settings = {
      security = {
        secret_key = "$__file{${config.age.secrets.grafana-secret-key.path}}";
        disable_initial_admin_creation = true;
      };
      server = {
        root_url = "https://grafana.lab.nya.vodka";
        domain = "grafana.lab.nya.vodka";
        http_port = 3000;
        http_addr = "::";
      };

      analytics.reporting_enabled = false;

      auth.disable_login_form = true;

      "auth.generic_oauth" = {
        enabled = true;
        name = "Kanidm";
        allow_sign_up = true;

        client_id = "grafana";
        client_secret = "$__file{${config.age.secrets.grafana-oauth-secret.path}}";

        scopes = "openid profile email groups";
        use_pkce = true;
        use_refresh_token = true;

        auth_url = "${cfg.oauth.baseUrl}/ui/oauth2";
        token_url = "${cfg.oauth.baseUrl}/oauth2/token";
        api_url = "${cfg.oauth.baseUrl}/oauth2/openid/grafana/userinfo";

        login_attribute_path = "preferred_username";
        groups_attribute_path = "groups";

        role_attribute_path = "contains(groups[*], 'grafana-admins@${cfg.domains.services.oauth}') && 'Admin' || contains(groups[*], 'grafana-editors') && 'Editor' || 'Viewer'";
        allow_assign_grafana_admin = true;
      };
    };
  };
}
