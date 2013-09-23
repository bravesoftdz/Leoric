unit LeoricMessages;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TLeoricSeverity = (
    Severity_None := 0,
    Severity_Info,
    Severity_Debug,
    Severity_Warning,
    Severity_Error
  );

  TLeoricMessage = Class(TObject)
  private
    FMessage : String;
    FCode : Word;
    FSeverity : TLeoricSeverity;
  public
    property Message: String read FMessage write FMessage;
    property Code: Word read FCode write FCode;
    property Severity: TLeoricSeverity read FSeverity write FSeverity;
    constructor Create;
  end;

  TLeoricMessages = Array of TLeoricMessage;

  TLeoricMessageHandler = Class(TObject)
  private
    FMessages : TLeoricMessages;
  public
    property Messages: TLeoricMessages read FMessages write FMessages;
    procedure AddMessage(Message : TLeoricMessage);
    procedure AddMessage(
      Message : String;
      Code: Word;
      Severity : TLeoricSeverity
    );
  end;

implementation

  constructor TLeoricMessage.Create;
  begin
    inherited;
    FMessage := '';
    FCode := 0;
    FSeverity := Severity_None;
  end;

  procedure TLeoricMessageHandler.AddMessage(Message : TLeoricMessage);
  begin
    FMessages[Length(FMessages)+1] := Message;
  end;

  procedure TLeoricMessageHandler.AddMessage(
    Message : String;
    Code : Word;
    Severity : TLeoricSeverity );
  var
    NewMessage : TLeoricMessage;
    MessageIndex : Integer;
  begin
    NewMessage.FMessage := Message;
    NewMessage.Code := Code;
    NewMessage.Severity := Severity;
    MessageIndex := Length(FMessages);
    SetLength(FMessages,MessageIndex+1);
    FMessages[MessageIndex] := NewMessage;
  end;

end.

