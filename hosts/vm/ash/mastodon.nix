{ ... }:

{
  services.mastodon = {
    enable = true;
    localDomain = "nya.vodka";
    configureNginx = true;
    smtp.fromAddress = "noreply@nya.vodka";
    streamingProcesses = 3;
  };
}
