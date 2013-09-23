unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LeoricGraphics;

type

  { TFrmMainWindow }

  TFrmMainWindow = class(TForm)
    ChkFullScreen: TCheckBox;
    CmdOk: TButton;
    LblTitle: TLabel;
    LblSelectResolution: TLabel;
    LstResolutions: TListBox;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FrmMainWindow: TFrmMainWindow;

implementation

{$R *.lfm}

{ TFrmMainWindow }

procedure TFrmMainWindow.FormCreate(Sender: TObject);
var
  GraphicsEngine: TLeoricGraphicsEngine;
  Resolutions : TGraphicsModes;
  Resolution : TGraphicsMode;
begin
  // Init Graphics Engine.
  GraphicsEngine := TLeoricGraphicsEngine.Create;
  // Attempt to get a list of video modes and fill listbox.
  Resolutions := GraphicsEngine.GetAvailableDisplayModesForCurrentDisplay;
  if Resolutions <> nil then
  begin
    for Resolution in Resolutions do
    begin
      LstResolutions.Items.Add(
        IntToStr(Resolution.Width) + 'x' + IntToStr(Resolution.Height)
      );
    end;
  end;
  // Dealloc Graphics Engine.
  GraphicsEngine.Destroy;
end;

end.

