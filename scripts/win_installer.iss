; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

;You must define Version by adding the command line argument /DVersion=x.x
;#define Version

; You must define Build by adding the command line argument  /DBuild=someint
;#define Build

; You must define the GitVersion by adding the command line argument /DGitVersion=version
;#define GitVersion

; You must define DestFile by adding the command line argument /DDestFile=destinationfile (without the .exe)
;#define DestFile

; You must define DestDir by adding the command line argument /DDestDir=dir/to/dest/file/
;#define DestDir

; You must define BuildDir by adding the command line argument /DBuildDir=dir/to/builds/
;#define BuildDir

; Specify a custom rooth path by adding the command line argument /DRootPath=path/to/root/dir
#ifndef RootPath
  #define RootPath "./"
#endif

; Specify the Architecture by adding the command line argument /DArch=
#ifndef Arch
  #define Arch "x64"
#endif
#if Arch == "x86"
  #define GitExecutable "Git-" + GitVersion + "-32-bit.exe"
  #define BuildPath RootPath + BuildDir + "translationStudio-win32-ia32\*.*"
  #define GitInstaller "win32_git_installer.iss"
#else
  #define GitExecutable "Git-" + GitVersion + "-64-bit.exe"
  #define BuildPath RootPath + BuildDir + "translationStudio-win32-x64\*.*"
  #define GitInstaller "win64_git_installer.iss"
#endif

#define MyAppName "translationStudio"
#define MyAppPublisher "Unfolding Word"
#define MyAppURL "https://unfoldingword.org"
#define MyAppExeName "translationStudio.exe"
#define MyLicenseFile RootPath + "LICENSE"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{8FE5DAA2-5922-411D-83A5-CB5708E7BB1E}
AppName={#MyAppName}
AppVersion={#Version}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir={#RootPath}{#DestDir}
OutputBaseFilename={#DestFile}
SetupIconFile={#RootPath}icons\icon.ico
Compression=lzma
SolidCompression=yes
LicenseFile={#MyLicenseFile}
#if Arch == "x86"
ArchitecturesAllowed=x86
#else
ArchitecturesAllowed=x64
#endif

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "greek"; MessagesFile: "compiler:Languages\Greek.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "serbiancyrillic"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl"
Name: "serbianlatin"; MessagesFile: "compiler:Languages\SerbianLatin.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "{#RootPath}vendor\{#GitExecutable}"; DestDir: "{app}\vendor"; Flags: ignoreversion recursesubdirs deleteafterinstall
Source: "{#RootPath}scripts\git\{#GitInstaller}"; DestDir: "{app}\vendor"; Flags: ignoreversion recursesubdirs deleteafterinstall
Source: "{#BuildPath}"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\vendor\{#GitExecutable}"; Parameters: "/SILENT /LOADINF=""{app}\vendor\{#GitInstaller}""";
; Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: postinstall skipifsilent
