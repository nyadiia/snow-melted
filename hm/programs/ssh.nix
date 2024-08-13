{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = builtins.listToAttrs (map (host: { name = host; value = { forwardAgent = true; };}) [
      "kmwc.org"
      "juniper"
      "alder"
      "cedar"
    ]);
  };
  services.ssh-agent.enable = true;
}
