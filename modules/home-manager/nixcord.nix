{ inputs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;

    discord = {
      vencord.enable = true;
      openASAR.enable = true;
    };

    config = {
      plugins = {
        betterGifPicker.enable = true;
        biggerStreamPreview.enable = true;
        ClearURLs.enable = true;
        crashHandler.enable = true;
        OnePingPerDM.enable = true;
        shikiCodeblocks.enable = true;
        whoReacted.enable = true;
        volumeBooster.enable = true;
        favoriteGifSearch.enable = true;
        voiceMessages.enable = true;
        noTypingAnimation.enable = true;
        sendTimestamps.enable = true;
      };
    };
  };
}
