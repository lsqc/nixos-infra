let
  # users
  lsqc = [
    "ssh-ed25519 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMe1eur6B43u8IZWoSeW0dEqC1+3vX8lMkmRxm5yFCuG"
  ];

  # systems
  immich = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTiP3yLx64FJgzjiqMFYUtmtDneUFtri6VNxaYlR4zB";

  hachi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjLW6Lac1Fz+AF6SHYuomvAY3Z0333Yoi4HAy1Ra47J";

  prometheus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA6tyB0ewv946ARed8n4UungdAizVLHK99aEkmpitk7C";
  kanidm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEip/cONgfa7qqVOtK11/lR47e+5Rq/ouXX5d9PoOKvu";

  # lxcs
  postgres1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIRjf6aP4hkuda6RbNV//Zzo7jiLFEoqEJaLSGVHDJXq";
in
{
  "immich-db.age".publicKeys = lsqc ++ [ immich ];
  "forgejo-mailer-password.age".publicKeys = lsqc ++ [ hachi ];
  "postgres-immich-pw.age".publicKeys = lsqc ++ [
    immich
    postgres1
  ];
  "postgres-postgres-pw.age".publicKeys = lsqc ++ [
    immich
    postgres1
  ];

  "grafana-secret-key.age" = {
    publicKeys = lsqc ++ [ prometheus ];
  };

  "grafana-oauth-secret.age" = {
    publicKeys = lsqc ++ [ prometheus ];
  };

  "kanidm-admin-password.age" = {
    publicKeys = lsqc ++ [ kanidm ];
  };
  "kanidm-idm-admin-password.age" = {
    publicKeys = lsqc ++ [ kanidm ];
  };
}
