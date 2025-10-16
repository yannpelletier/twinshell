import Quickshell
import QtQuick.Layouts
import Quickshell.Io
import QtQuick

JsonObject {
  id: root

  property bool light: false

  // Core Colors
  property color primary: "#7AA2F7" // TokyoDark blue for primary elements
  property color primaryContent: "#C0CAF5" // Light blue for text/icon on primary
  property color primaryContainer: "#3B4261" // Darker blue for containers
  property color primaryContainerContent: "#A9B1D6" // Light grayish-blue for content
  property color secondary: "#F7768E" // TokyoDark pink for secondary elements
  property color secondaryContent: "#C0CAF5" // Light blue for text/icon on secondary
  property color secondaryContainer: "#4E3B4B" // Darker pink/purple for containers
  property color secondaryContainerContent: "#E0B7C8" // Light pink for content
  property color tertiary: "#B4F9F8" // TokyoDark cyan for tertiary elements
  property color tertiaryContent: "#1A1B26" // Dark background for contrast
  property color tertiaryContainer: "#2E5963" // Darker cyan for containers
  property color tertiaryContainerContent: "#A9E3E3" // Light cyan for content
  property color background: "#1A1B26" // TokyoDark main dark background
  property color backgroundContent: "#C0CAF5" // Light blue for text on background
  property color surface: "#24283B" // Slightly lighter than background
  property color surfaceContent: "#C0CAF5" // Light blue for text on surface

  // Surface Variants
  property color surfaceVariant: "#414868" // Muted gray for surface variants
  property color surfaceVariantContent: "#A9B1D6" // Light grayish-blue for content
  property color surfaceDim: "#14151F" // Darker than background
  property color surfaceBright: "#353652" // Slightly brighter surface
  property color surfaceContainerLowest: "#0F1018" // Darkest surface
  property color surfaceContainerLow: "#1E2133" // Low contrast surface
  property color surfaceContainer: "#24283B" // Standard surface container
  property color surfaceContainerHigh: "#2E334F" // Higher contrast surface
  property color surfaceContainerHighest: "#383F61" // Highest contrast surface

  // Other Colors
  property color outline: "#565F89" // Muted blue-gray for outlines
  property color outlineVariant: "#414868" // Alternative outline color
  property color shadow: "#000000" // Black for shadows
  property color scrim: "#000000" // Black for scrims
  property color inverseSurface: "#C0CAF5" // Light blue for inverted surfaces
  property color inverseSurfaceContent: "#1A1B26" // Dark background for contrast
  property color inversePrimary: "#3455DB" // Darker blue for inverse primary
  property color surfaceTint: "#7AA2F7" // Blue tint matching primary

  // Optional Colors
  property color success: "#9ECE6A" // TokyoDark green for success
  property color successContent: "#1A1B26" // Dark background for contrast
  property color successContainer: "#3F4A35" // Darker green for containers
  property color successContainerContent: "#B7E092" // Light green for content

  // Error Colors
  property color error: "#F7768E" // TokyoDark pink for errors (reused for consistency)
  property color errorContent: "#1A1B26" // Dark background for contrast
  property color errorContainer: "#4E3B4B" // Darker pink for error containers
  property color errorContainerContent: "#E0B7C8" // Light pink for content

  // Term Colors
  property color term0: primary
  property color term1: primaryContent
  property color term2: primaryContainer
  property color term3: primaryContainerContent
  property color term4: secondary
  property color term5: secondaryContent
  property color term6: secondaryContainer
  property color term7: secondaryContainerContent
  property color term8: tertiary
  property color term9: tertiaryContent
  property color term10: tertiaryContainer
  property color term11: tertiaryContainerContent
  property color term12: surface
  property color term13: surfaceContent
  property color term14: surfaceVariant
  property color term15: surfaceVariantContent
}
