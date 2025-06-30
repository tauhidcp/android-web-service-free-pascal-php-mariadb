unit utambah;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, fpjson, jsonparser;
  
type

  { TMTambah }

  TMTambah = class(jForm)
    BSimpan: jButton;
    ENoHP: jEditText;
    ENama: jEditText;
    HttpClient1: jHttpClient;
    Judul: jTextView;
    PanelAtas: jPanel;
    PanelUtama: jPanel;
    TextHP: jTextView;
    TextNama: jTextView;
    procedure BSimpanClick(Sender: TObject);
  private
    {private declarations}
  public
    {public declarations}
    procedure ClearInput;
  end;

var
  MTambah: TMTambah;

  
implementation

uses uutama;
  
  
{$R *.lfm}
  

  
{ TMTambah }

procedure TMTambah.BSimpanClick(Sender: TObject);
var
    Data: TJSONData;
    Simpan : String;
    JParser  : TJSONParser;
    JDoc     : TJSONObject;
  begin

  if not (ENama.Text='') and not (ENoHP.Text='') then
    begin
      try
        Data := GetJSON('{"nama" : "'+ENama.Text+'", "nohp" : "'+ENoHP.Text+'"}');
        Simpan := HttpClient1.PostJSONData(MUtama.EServerIP.Text+'/webapi/inputcontact.php', Data.AsJSON);
        JParser := TJSONParser.Create(Simpan);
        JDoc := TJSONObject(JParser.Parse);
        ShowMessage(JDoc.FindPath('Respon').AsString);
      finally
        JParser.Free;
        JDoc.Free;
      end;
    end;
end;

procedure TMTambah.ClearInput;
begin
  ENama.Text:='';
  ENoHP.Text:='';
end;

end.
