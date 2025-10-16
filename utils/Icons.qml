pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

Singleton {
  id: root

  readonly property var osIcons: ({
    almalinux: "",
    alpine: "",
    arch: "",
    archcraft: "",
    arcolinux: "",
    artix: "",
    centos: "",
    debian: "",
    devuan: "",
    elementary: "",
    endeavouros: "",
    fedora: "",
    freebsd: "",
    garuda: "",
    gentoo: "",
    hyperbola: "",
    kali: "",
    linuxmint: "󰣭",
    mageia: "",
    openmandriva: "",
    manjaro: "",
    neon: "",
    nixos: "",
    opensuse: "",
    suse: "",
    sles: "",
    sles_sap: "",
    "opensuse-tumbleweed": "",
    parrot: "",
    pop: "",
    raspbian: "",
    rhel: "",
    rocky: "",
    slackware: "",
    solus: "",
    steamos: "",
    tails: "",
    trisquel: "",
    ubuntu: "",
    vanilla: "",
    void: "",
    zorin: ""
  })

  readonly property var weatherIcons: ({
    "113": "clear_day",
    "116": "partly_cloudy_day",
    "119": "cloud",
    "122": "cloud",
    "143": "foggy",
    "176": "rainy",
    "179": "rainy",
    "182": "rainy",
    "185": "rainy",
    "200": "thunderstorm",
    "227": "cloudy_snowing",
    "230": "snowing_heavy",
    "248": "foggy",
    "260": "foggy",
    "263": "rainy",
    "266": "rainy",
    "281": "rainy",
    "284": "rainy",
    "293": "rainy",
    "296": "rainy",
    "299": "rainy",
    "302": "weather_hail",
    "305": "rainy",
    "308": "weather_hail",
    "311": "rainy",
    "314": "rainy",
    "317": "rainy",
    "320": "cloudy_snowing",
    "323": "cloudy_snowing",
    "326": "cloudy_snowing",
    "329": "snowing_heavy",
    "332": "snowing_heavy",
    "335": "snowing",
    "338": "snowing_heavy",
    "350": "rainy",
    "353": "rainy",
    "356": "rainy",
    "359": "weather_hail",
    "362": "rainy",
    "365": "rainy",
    "368": "cloudy_snowing",
    "371": "snowing",
    "374": "rainy",
    "377": "rainy",
    "386": "thunderstorm",
    "389": "thunderstorm",
    "392": "thunderstorm",
    "395": "snowing"
  })

  readonly property var desktopEntrySubs: ({
    "gimp-3.0": "gimp"
  })

  readonly property var categoryIcons: ({
    WebBrowser: "web",
    Printing: "print",
    Security: "security",
    Network: "chat",
    Archiving: "archive",
    Compression: "archive",
    Development: "code",
    IDE: "code",
    TextEditor: "edit_note",
    Audio: "music_note",
    Music: "music_note",
    Player: "music_note",
    Recorder: "mic",
    Game: "sports_esports",
    FileTools: "files",
    FileManager: "files",
    Filesystem: "files",
    FileTransfer: "files",
    Settings: "settings",
    DesktopSettings: "settings",
    HardwareSettings: "settings",
    TerminalEmulator: "terminal",
    ConsoleOnly: "terminal",
    Utility: "build",
    Monitor: "monitor_heart",
    Midi: "graphic_eq",
    Mixer: "graphic_eq",
    AudioVideoEditing: "video_settings",
    AudioVideo: "music_video",
    Video: "videocam",
    Building: "construction",
    Graphics: "photo_library",
    "2DGraphics": "photo_library",
    RasterGraphics: "photo_library",
    TV: "tv",
    System: "host",
    Office: "content_paste"
  })

  property string osIcon: ""
  property string osName

  function getDesktopEntry(name: string): DesktopEntry {
    const originalName = name;
    name = name.toLowerCase().replace(/ /g, "-");

    let entry = DesktopEntries.applications.values.find(a => a.id.toLowerCase() === name) ?? null;

    if (!entry) {
      const normalizedOriginal = originalName.toLowerCase().replace(/ /g, "");
      entry = DesktopEntries.applications.values.find(a => 
        a.name.toLowerCase().includes(normalizedOriginal) || 
        normalizedOriginal.includes(a.name.toLowerCase().replace(/ /g, ""))
      );
    }

    return entry ?? null;
  }

  function getAppIcon(name: string, fallback: string): string {
    const entry = getDesktopEntry(name);
    if (entry && entry.icon) {
      return Quickshell.iconPath(entry.icon, fallback);
    }
    
    // Enhanced fallback: try direct icon lookup using normalized app name (works for many apps without .desktop)
    const normalizedName = name.toLowerCase().replace(/ /g, "-").replace(/[^a-z0-9-]/g, "");
    return Quickshell.iconPath(normalizedName, fallback);
  }

  function getAppCategoryIcon(name: string, fallback: string): string {
    const categories = getDesktopEntry(name)?.categories;

    if (categories)
      for (const [key, value] of Object.entries(categoryIcons))
        if (categories.includes(key))
          return value;
    return fallback;
  }

  function getBatteryIcon(percentage: int, charging: bool): string {
    const batteryIcons = {
      charging: [
        { min: 95, icon: "battery_full" },
        { min: 90, icon: "battery_charging_90" },
        { min: 80, icon: "battery_charging_80" },
        { min: 60, icon: "battery_charging_60" },
        { min: 50, icon: "battery_charging_50" },
        { min: 30, icon: "battery_charging_30" },
        { min: 20, icon: "battery_charging_20" },
        { min: 0, icon: "battery_charging_full" }
      ],
      nonCharging: [
        { min: 90, icon: "battery_full" },
        { min: 80, icon: "battery_6_bar" },
        { min: 60, icon: "battery_5_bar" },
        { min: 50, icon: "battery_4_bar" },
        { min: 30, icon: "battery_3_bar" },
        { min: 20, icon: "battery_2_bar" },
        { min: 10, icon: "battery_1_bar" },
        { min: 0, icon: "battery_0_bar" }
      ]
    };

    const iconSet = charging ? batteryIcons.charging : batteryIcons.nonCharging;
    return iconSet.find(level => percentage >= level.min).icon;
  }

  function getNetworkIcon(strength: int, wired: bool): string {
    if (wired) {
      return "lan";
    }

    const wifiIcons = [
      { min: 66, icon: "wifi" },
      { min: 33, icon: "wifi_2_bar" },
      { min: 0, icon: "wifi_1_bar" },
    ];

    return wifiIcons.find(level => strength >= level.min).icon;
  }

  function getBrightnessIcon(brightness: int): string {
    const brightnessIcons = [
      { min: 86, icon: "brightness_7" },
      { min: 71, icon: "brightness_6" },
      { min: 56, icon: "brightness_5" },
      { min: 41, icon: "brightness_4" },
      { min: 26, icon: "brightness_3" },
      { min: 11, icon: "brightness_2" },
      { min: 0, icon: "brightness_1" }
    ];

    let result = brightnessIcons.find(level => brightness >= level.min);
    return result ? result.icon : "brightness_1";
  }

  function getSpeakerIcon(volume: int, muted: bool): string {
    if (muted) 
      return "volume_off"

    const speakerVolumeIcons = [
      { min: 66, icon: "volume_up" },
      { min: 33, icon: "volume_down" },
      { min: 0, icon: "volume_mute" }
    ];
    let result = speakerVolumeIcons.find(level => volume >= level.min);
    return result ? result.icon : "volume_mute";
  }

  function getMicrophoneIcon(muted: bool): string {
    return muted ? "mic_off" : "mic"
  }


  function getBluetoothIcon(icon: string): string {
    if (icon.includes("headset") || icon.includes("headphones"))
      return "headphones";
    if (icon.includes("audio"))
      return "speaker";
    if (icon.includes("phone"))
      return "smartphone";
    if (icon.includes("mouse"))
      return "mouse";
    if (icon.includes("keyboard"))
      return "keyboard";
    return "bluetooth";
  }

  function getWeatherIcon(code: string): string {
    if (weatherIcons.hasOwnProperty(code))
      return weatherIcons[code];
    return "air";
  }

  function getNotifIcon(summary: string, urgency: int): string {
    if (summary.includes("reboot"))
      return "restart_alt";
    if (summary.includes("recording"))
      return "screen_record";
    if (summary.includes("battery"))
      return "power";
    if (summary.includes("screenshot"))
      return "screenshot_monitor";
    if (summary.includes("welcome"))
      return "waving_hand";
    if (summary.includes("time") || summary.includes("a break"))
      return "schedule";
    if (summary.includes("installed"))
      return "download";
    if (summary.includes("update"))
      return "update";
    if (summary.includes("unable to"))
      return "deployed_code_alert";
    if (summary.includes("profile"))
      return "person";
    if (summary.includes("file"))
      return "folder_copy";
    if (urgency === NotificationUrgency.Critical)
      return "release_alert";
    return "chat";
  }

  FileView {
    path: "/etc/os-release"
    onLoaded: {
      const lines = text().split("\n");
      let osId = lines.find(l => l.startsWith("ID="))?.split("=")[1];
      if (root.osIcons.hasOwnProperty(osId))
        root.osIcon = root.osIcons[osId];
      else {
        const osIdLike = lines.find(l => l.startsWith("ID_LIKE="))?.split("=")[1];
        if (osIdLike)
          for (const id of osIdLike.split(" "))
            if (root.osIcons.hasOwnProperty(id))
                return root.osIcon = root.osIcons[id];
      }

      let nameLine = lines.find(l => l.startsWith("PRETTY_NAME="));
      if (!nameLine)
        nameLine = lines.find(l => l.startsWith("NAME="));
      root.osName = nameLine.split("=")[1].slice(1, -1);
    }
  }
}
