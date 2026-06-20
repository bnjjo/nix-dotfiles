{
  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/ssh"
        "/etc/NetworkManager/system-connections"
        "/var/log"
        "/var/NetworkManager"
        "/var/lib/bluetooth"
        "/var/lib/flatpak"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      # Preserve user files
      users.benjamin = {
        directories = [
          ".cache"
          ".config"
          ".local"
          ".ssh"
          ".var"
          ".ViberPC"
          "Code"
          "Downloads"
          "Pictures"
          "orgfiles"
          "nix-dotfiles"
        ];

        files = [
        ];
      };
    };
  };
}
