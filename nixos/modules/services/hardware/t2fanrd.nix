{ config, pkgs, lib, ... }:
let
  cfg = config.services.t2fanrd;
in {
  options.services.t2fanrd = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = true;
      description = "Enables Fan control service for T2 Macs";
    };

    # TODO: How do I split up the options for each fan?

    lowTemp = lib.mkOption {
      type  = lib.types.int;
      default = 55;
      example = "40";
      description = "Temperature that will trigger higher fan speed";
    };

    highTemp = lib.mkOption {
      type  = lib.types.int;
      default = 75;
      example = "80";
      description = "Temperature that will trigger higher fan speed";
    };

    speedCurve = lib.mkOption {
      type = lib.types.string;
      default = "linear"; # linear?
      example = "logarithmic";  # string?
      description = "Set the fan speed. There is three options; linear, exponential and logarithmic";
    };

    alwaysFullSpeed = lib.mkOption {
      type = lib.types.bool;
      default = false;
      example = "true";
      description = "if set \"true\", the fan will be at max speed no matter what.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.t2fanrd = {
      description = "T2FanRD daemon to manage fan curves for t2 macs";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "exec";
        ExecStart = "${pkgs.t2fanrd}/bin/t2fanrd";
        Restart = "always";
      };
    };

    environment.systemPackages = [ pkgs.t2fanrd ];

    # TODO: can i enumerate this ?
    environment.etc."t2fand.conf".text = ''
      [Fan1]
      low_temp=${cfg.lowTemp}
      high_temp=${cfg.highTemp}
      speed_curve=${cfg.speedCurves}
      always_full_speed=${cfg.alwaysFullSpeed}

      [Fan2]
      low_temp=${cfg.lowTemp}
      high_temp=${cfg.highTemp}
      speed_curve=${cfg.speedCurves}
      always_full_speed=${cfg.alwaysFullSpeed}
    '';
  };
}
