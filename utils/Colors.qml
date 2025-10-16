pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  id: root

  function rgbToRgba(rgb: color, alpha: real) {
    hex = String(hex).replace("#", "");
    
    if (hex.length !== 6 || !/^[0-9A-Fa-f]{6}$/.test(hex)) {
      console.warn("Invalid hex RGB format. Expected 6 hexadecimal characters.");
      return "#000000FF"; // Fallback
    }

    alpha = Math.max(0, Math.min(1, alpha));
    let alphaHex = Math.round(alpha * 255).toString(16).padStart(2, "0").toLowerCase();

    console.log(`#${hex.toLowerCase()}${alphaHex}`)
    return `#${hex.toLowerCase()}${alphaHex}`;
  }
}
