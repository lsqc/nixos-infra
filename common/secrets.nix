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
  };
}
