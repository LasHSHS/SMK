; Snapchat Memories Keeper - Inno Setup Script
; Creates a professional Windows installer

[Setup]
AppName=Snapchat Memories Keeper
AppVersion=1.0.2
AppPublisher=Las HS
AppPublisherURL=https://github.com/LasHSHS
DefaultDirName={autopf}\Snapchat Memories Keeper
DefaultGroupName=Snapchat Memories Keeper
OutputDir=installer_output
OutputBaseFilename=Snapchat-Memories-Keeper-Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
ArchitecturesInstallIn64BitMode=x64
AllowNoIcons=yes
ShowLanguageDialog=no
LicenseFile=LICENSE
SetupIconFile=icon.ico
UninstallDisplayIcon={app}\SMK.exe
DisableWelcomePage=no

; Modern UI settings - using built-in defaults

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
; Main executable and all its dependencies from dist\smd folder
Source: "dist\smd\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; Copy icon separately for shortcuts
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
; Create Start Menu shortcuts
Name: "{group}\Snapchat Memories Keeper"; Filename: "{app}\SMK.exe"; IconFilename: "{app}\icon.ico"; Comment: "Keep your Snapchat memories offline"; WorkingDir: "{app}"
Name: "{group}\Uninstall Snapchat Memories Keeper"; Filename: "{uninstallexe}"
; Optional: Create desktop shortcut
Name: "{userdesktop}\Snapchat Memories Keeper"; Filename: "{app}\SMK.exe"; IconFilename: "{app}\icon.ico"; Comment: "Keep your Snapchat memories offline"; WorkingDir: "{app}"

[Run]
; Ask user if they want to launch the app after installation
Filename: "{app}\SMK.exe"; Description: "Launch Snapchat Memories Keeper"; Flags: nowait postinstall skipifsilent unchecked; WorkingDir: "{app}"

[InstallDelete]
; Clean up old versions
Type: filesandordirs; Name: "{app}\*"

[Code]
// Check if .NET is installed (optional - remove if not needed)
function IsNetInstalledAndNew(): Boolean;
var
  Version: string;
begin
  Result := True; // For now, assume it's fine - Python 3.12 is self-contained
end;

// Custom wizard page to show post-install info
procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpFinished then
    MsgBox('Snapchat Memories Keeper has been installed successfully!' + #13#13 +
           'Everything is included — no Python, ffmpeg, or other tools to install.' + #13#13 +
           'Click Finish, then open SMK from the Start Menu.' + #13#13 +
           'For support, visit: https://github.com/LasHSHS/SMK',
           mbInformation, MB_OK);
end;
