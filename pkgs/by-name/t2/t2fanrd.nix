{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "T2FanRD";
  version = "v0.1.0";

  src = fetchFromGitHub {
    owner = "GnomedDev";
    repo = "T2FanRD";
    tag = finalAttrs.version;
    # rev = "85027878e4d7fa0170fea1213d6f8dd972d60e83";
    hash = "sha256-vOJAYbB/ZcRxM+/lrkab/PcON3vOz3o6eqPvM9hmaOw=";
  };

  cargoHash = "sha256-FKQYiaOTZxD95AWD2zbVjENzMAPrFl/rzhwbkAgGbx0=";

  meta = {
    description = "Simple Fan Daemon for T2 Macs, rewritten from the original Python version.";
    homepage = "https://github.com/GnomedDev/T2FanRD";
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
  };
})
