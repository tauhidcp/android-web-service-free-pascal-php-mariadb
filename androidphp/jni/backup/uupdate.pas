unit uupdate;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, fpjson, jsonparser,;
  
type

  { TMUpdate }

  TMUpdate = class(jForm)
    BUpdate: jButton;
    EID: jEditText;
    ENama: jEditText;
    ENoHP: jEditText;
    HttpClient1: jHttpClient;
    PanelUtama: jPanel;
    TextHP: jTextView;
    TextNama: jTextView;
    TextID: jTextView;
    procedure BUpdateClick(Sender: TObject);
  private
    {private declarations}
  public
    {public declarations}
    procedure ClearInput;
  end;

var
  MUpdate: TMUpdate;

  
implementation
  
  
{$R *.lfm}
  

  
{ TMUpdate }

procedure TMUpdate.BUpdateClick(Sender: TObject);
var
    Data: TJSONData;
    Update : String;
    JParser  : TJSONParser;
    JDoc     : TJSONObject;
  begin

  if not (ENama.Text='') and not (ENoHP.Text='') and not (EID.Text='') then
    begin
      try
        Data := GetJSON('{"nama" : "'+ENama.Text+'", "nohp" : "'+ENoHP.Text+'", "id" : "'+EID.Text+'"}');
        Update := HttpClient1.PostJSONData('http://192.168.1.12/webapi/updatecontact.php', Data.AsJSON);
        JParser := TJSONParser.Create(Update);
        JDoc := TJSONObject(JParser.Parse);
        ShowMessage(JDoc.FindPath('Respon').AsString);
      finally
        JParser.Free;
        JDoc.Free;
      end;
    end;
end;

procedure TMUpdate.ClearInput;
begin
  EID.Text:='';
  ENama.Text:='';
  ENoHP.Text:='';
end;

end.
