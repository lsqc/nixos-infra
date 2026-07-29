{ config, ... }:

{
  services.netbox = {
    enable = true;
    apiTokenPeppersFile = config.age.secrets.netbox-api-token-peppers.path;
    secretKeyFile = config.age.secrets.netbox-secret-key.path;
  };
}
