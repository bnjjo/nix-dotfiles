{pkgs, ...}: {
  services.flatpak = {
    enable = true;
    packages = [
      "com.valvesoftware.Steam"
      "com.viber.Viber"
    ];
  };
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 180;
        command = "${pkgs.wlopm}/bin/wlopm --off '*'";
        resumeCommand = "${pkgs.wlopm}/bin/wlopm --on '*'";
      }
      {
        timeout = 600;
        command = "systemctl suspend";
      }
    ];
  };
}
