{ ... }:

{
  age.secrets = {
    immich-db.file = ../secrets/immich-db.age;
    postgres-immich-pw.file = ../secrets/postgres-immich-pw.age;
    postgres-postgres-pw.file = ../secrets/postgres-postgres-pw.age;
    forgejo-mailer-password.file = ../secrets/forgejo-mailer-password.age;
    grafana-secret-key = {
      file = ../secrets/grafana-secret-key.age;
      owner = "grafana";
      group = "grafana";
    };
    kanidm-admin-password = {
      file = ../secrets/kanidm-admin-password.age;
      owner = "kanidm";
      group = "kanidm";
      mode = "0400";
    };
    kanidm-idm-admin-password = {
      file = ../secrets/kanidm-idm-admin-password.age;
      owner = "kanidm";
      group = "kanidm";
      mode = "0400";
    };
    netbox-api-token-peppers = {
      file = ../secrets/netbox-api-token-peppers.age;
      owner = "netbox";
      group = "netbox";
      mode = "0400";
    };
    netbox-secret-key = {
      file = ../secrets/netbox-secret-key.age;
      owner = "netbox";
      group = "netbox";
      mode = "0400";
    };
  };
}
