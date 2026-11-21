{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  cmake,
  ninja,
  python3,
  libjpeg,
  openssl,
  libopus,
  ffmpeg,
  openh264,
  crc32c,
  libvpx,
  libx11,
  libxtst,
  libxcomposite,
  libxdamage,
  libxext,
  libxrender,
  libxrandr,
  libxi,
  glib,
  abseil-cpp,
  pipewire,
  libgbm,
  libdrm,
  libGL,
  apple-sdk_15,
  unstableGitUpdater,
}:

stdenv.mkDerivation {
  pname = "tg_owt";
  version = "0-unstable-2026-11-15";

  src = fetchFromGitHub {
    owner = "desktop-app";
    repo = "tg_owt";
    rev = "642ddb107b42da7c8d152401b71cd429475e5266";
    hash = "sha256-seuGyfjlk/SvKAtbRMm4/PJlV7Dlfp6LKue/U67D9GI=";
    fetchSubmodules = true;
  };

  patches = [
  ];

  postPatch = lib.optionalString stdenv.hostPlatform.isLinux ''
    substituteInPlace src/modules/desktop_capture/linux/wayland/egl_dmabuf.cc \
      --replace-fail '"libEGL.so.1"' '"${lib.getLib libGL}/lib/libEGL.so.1"' \
      --replace-fail '"libGL.so.1"' '"${lib.getLib libGL}/lib/libGL.so.1"' \
      --replace-fail '"libgbm.so.1"' '"${lib.getLib libgbm}/lib/libgbm.so.1"' \
      --replace-fail '"libdrm.so.2"' '"${lib.getLib libdrm}/lib/libdrm.so.2"'
  '';

  outputs = [
    "out"
    "dev"
  ];

  nativeBuildInputs = [
    pkg-config
    cmake
    ninja
    python3
  ];

  propagatedBuildInputs = [
    libjpeg
    openssl
    libopus
    ffmpeg
    openh264
    crc32c
    libvpx
    abseil-cpp
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    libx11
    libxtst
    libxcomposite
    libxdamage
    libxext
    libxrender
    libxrandr
    libxi
    glib
    pipewire
    libgbm
    libdrm
    libGL
  ]
  ++ lib.optionals stdenv.hostPlatform.isDarwin [
    apple-sdk_15
  ];

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    description = "Fork of Google's webrtc library for telegram-desktop";
    homepage = "https://github.com/desktop-app/tg_owt";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ oxalica ];
    platforms = lib.platforms.linux ++ ["aarch64-darwin"];
  };
}
