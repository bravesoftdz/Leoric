unit LeoricGraphics;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLType, Forms, sdl, LeoricMessages;

type

  TGraphicsMode = record
    Width : Word;
    Height : Word;
  end;

  TGraphicsModes = Array of TGraphicsMode;

  TLeoricGraphicsEngine = class(TObject)
  private
    Initialized : Boolean;
    Type EUninitializedException = Class(Exception);
  public
    Messages : TLeoricMessageHandler;
    constructor Create;
    destructor Destroy;
    function GetAvailableDisplayModesForCurrentDisplay: TGraphicsModes;
  end;

implementation

  constructor TLeoricGraphicsEngine.Create;
  begin
    inherited;
    SDL_Init(SDL_INIT_VIDEO);
    Initialized := True;
  end;

  destructor TLeoricGraphicsEngine.Destroy;
  begin
    inherited;
    SDL_Quit;
  end;

  function TLeoricGraphicsEngine.GetAvailableDisplayModesForCurrentDisplay
    : TGraphicsModes;
  var
    ModeDimensions : PPSDL_Rect;
    CurrentMode : PSDL_Rect;
    ModeArrayIndex : Integer;
    CurrentModeOutput : TGraphicsMode;
  begin
    // Constructor needs to be called.
    if Initialized = False then
    begin
      Raise EUninitializedException.Create(
      'Leoric Graphics Engine needs to be initialized before calling this.');
    end;
    // Attempt to get a list of video modes.
    ModeDimensions := SDL_ListModes(
      nil,                         // Pixel format
      SDL_OPENGL or SDL_FULLSCREEN // flags
    );
    // Handle problems.
    if ((ModeDimensions = PPSDL_Rect(0)) or (ModeDimensions = PPSDL_Rect(-1)))
    then
    begin
      Messages.AddMessage('Could not get video mode list',100,Severity_Warning);
      Exit(nil);
    end;
    // Compose result.
    ModeArrayIndex := 0;
    while (ModeDimensions^ <> nil) do
    begin
      SetLength(Result,ModeArrayIndex+1);
      CurrentModeOutput.Width := (ModeDimensions^)^.w;
      CurrentModeOutput.Height := (ModeDimensions^)^.h;
      Result[ModeArrayIndex] := CurrentModeOutput;
      Inc(ModeDimensions);
      Inc(ModeArrayIndex);
    end;
  end;

end.

