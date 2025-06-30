unit uutama;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, fpjson, jsonparser,
  utambah, uupdate, uupload, ugetdata, And_jni, stoolbar;
  
type

  { TMUtama }

  TMUtama = class(jForm)
    BGetData: jButton;
    BUpdate: jButton;
    BHapus: jButton;
    BTambah: jButton;
    BUpload: jButton;
    EServerIP: jEditText;
    HttpClient1: jHttpClient;
    Judul: jTextView;
    PanelBawah: jPanel;
    TextServerIP: jTextView;
    Toolbar: jsToolbar;
    procedure BGetDataClick(Sender: TObject);
    procedure BHapusClick(Sender: TObject);
    procedure BTambahClick(Sender: TObject);
    procedure BUpdateClick(Sender: TObject);
    procedure BUploadClick(Sender: TObject);
    procedure MUtamaActivityResult(Sender: TObject; requestCode: integer;
      resultCode: TAndroidResult; intentData: jObject);
    procedure MUtamaJNIPrompt(Sender: TObject);
  private
    {private declarations}
  public
    procedure CloseModule;
    procedure ClearSelectData;
    {public declarations}
  end;

var
  MUtama: TMUtama;

  
implementation
  
  
{$R *.lfm}
  

  
{ TMUtama }

procedure TMUtama.BGetDataClick(Sender: TObject);
var
   Contact : AnsiString;
   j : integer;
   ParsedArray: TJSONArray;
   Item: TJSONObject;
   id,nama,nohp:String;
 begin

    CloseModule;
    MGetData.PanelUtama.Visible:= True;
    MGetData.PanelUtama.BringToFront();
    MGetData.ListContact.Clear;

   try
       Contact := HttpClient1.Get(EServerIP.Text+'/webapi/datacontact.php');
       ParsedArray := TJSONArray(GetJSON(Contact));

       for j := 0 to ParsedArray.Count - 1 do
       begin
         Item := ParsedArray.Objects[j];
         id   := Item.Get('id','');
         nama := Item.Get('nama','');
         nohp := Item.Get('nohp','');
         MGetData.ListContact.Add(id+'|'+nama+'|'+nohp+'');
       end;
       ClearSelectData;

   finally
     ParsedArray.Free;
   end;
 end;

procedure TMUtama.BHapusClick(Sender: TObject);
var
   idx, Hapus : string;
   Data       : TJSONData;
   JParser  : TJSONParser;
   JDoc     : TJSONObject;
begin
   if not (MGetData = nil) then
   begin
     idx := MGetData.IDText.Text;
     if (idx <> '') then
        begin
        try
           Data := GetJSON('{"id" : "'+idx+'"}');
           Hapus   := HttpClient1.PostJSONData(EServerIP.Text+'/webapi/deletecontact.php',Data.AsJSON);
           JParser := TJSONParser.Create(Hapus);
           JDoc := TJSONObject(JParser.Parse);
           ShowMessage(JDoc.FindPath('Respon').AsString);
           MGetData.ListContact.Delete(StrToInt(MGetData.Index.Text));
           ClearSelectData;
        finally
          JDoc.Free;
          JParser.Free;
        end;
        end else
        ShowMessage('Pilih Data Terlebih Dahulu!');
   end else
        ShowMessage('Get Data Terlebih Dahulu!');
end;

procedure TMUtama.BTambahClick(Sender: TObject);
begin
 CloseModule;
 MTambah.ClearInput;
 MTambah.PanelUtama.Visible:= True;
 MTambah.PanelUtama.BringToFront();
end;

procedure TMUtama.BUpdateClick(Sender: TObject);
begin
 if not (MGetData = nil) then
    begin

    if not (MGetData.IDText.Text='') then
       begin
         CloseModule;
         MUpdate.ClearInput;
         MUpdate.EID.Text:=MGetData.IDText.Text;
         MUpdate.ENama.Text:=MGetData.NamaText.Text;
         MUpdate.ENoHP.Text:=MGetData.NoHPText.Text;
         MUpdate.PanelUtama.Visible:= True;
         MUpdate.PanelUtama.BringToFront();
       end else
       ShowMessage('Pilih Data Terlebih Dahulu!');
    end else
      ShowMessage('Get Data Terlebih dahulu!');
end;

procedure TMUtama.BUploadClick(Sender: TObject);
begin
 CloseModule;
 MUpload.PanelUtama.Visible:= True;
 MUpload.TextOutput.Visible:=False;
 MUpload.PanelUtama.BringToFront();
end;

procedure TMUtama.MUtamaActivityResult(Sender: TObject; requestCode: integer;
  resultCode: TAndroidResult; intentData: jObject);
begin
  if  requestCode =  1001 then
  begin
    if resultCode = RESULT_OK then
    begin
    //MUpload.EPathFile.Text:=GetRealPathFromURI(MUpload.IntentManager1.GetDataUri(intentData)); // Not Work on API 33+
    MUpload.ENamaFile.Text:=GetFileNameByUri(MUpload.IntentManager1.GetDataUri(intentData));
    CopyFileFromUri(MUpload.IntentManager1.GetDataUri(intentData),GetEnvironmentDirectoryPath(dirDownloads));
    MUpload.EPathFile.Text:=GetEnvironmentDirectoryPath(dirDownloads)+'/'+GetFileNameByUri(MUpload.IntentManager1.GetDataUri(intentData));
  end;
  end;
end;

procedure TMUtama.MUtamaJNIPrompt(Sender: TObject);
var
  manifestPermissions: array of string;
begin
   // Request Permission For Upload & Download
    if IsRuntimePermissionNeed() then
   begin
      SetLength(manifestPermissions, 1);
      manifestPermissions[0]:= 'android.permission.WRITE_EXTERNAL_STORAGE';
      Self.RequestRuntimePermission(manifestPermissions, 6001);
      SetLength(manifestPermissions, 0);
   end;
   //Create Android Module
   gApp.CreateForm(TMGetData, MGetData);
   MGetData.Init;
   MGetData.PanelUtama.Parent:= Self.PanelBawah;
   MGetData.PanelUtama.SetViewParent(Self.PanelBawah.View);
   MGetData.PanelUtama.Visible:= False;
   gApp.CreateForm(TMTambah, MTambah);
   MTambah.Init;
   MTambah.PanelUtama.Parent:= Self.PanelBawah;
   MTambah.PanelUtama.SetViewParent(Self.PanelBawah.View);
   MTambah.PanelUtama.Visible:=False;
   gApp.CreateForm(TMUpdate, MUpdate);
   MUpdate.Init;
   MUpdate.PanelUtama.Parent:= Self.PanelBawah;
   MUpdate.PanelUtama.SetViewParent(Self.PanelBawah.View);
   MUpdate.PanelUtama.Visible:=False;
   gApp.CreateForm(TMUpload, MUpload);
   MUpload.Init;
   MUpload.PanelUtama.Parent:= Self.PanelBawah;
   MUpload.PanelUtama.SetViewParent(Self.PanelBawah.View);
   MUpload.PanelUtama.Visible:=False;

   Toolbar.SetFitsSystemWindows(True);
   Toolbar.SetBackgroundToPrimaryColor();
   //Toolbar.NavigationIconIdentifier:= 'ic_menu_white_36dp';
   Toolbar.SetTitleTextColor(colbrWhite);
   Toolbar.SetTitle('AndroidPHP');
   Toolbar.SetSubtitleTextColor(colbrWhite);
   Toolbar.SetSubtitle('Aplikasi Web Service Android + PHP + MariaDB');
end;

procedure TMUtama.CloseModule;
begin
  MUpload.PanelUtama.Visible := False;
  MUpdate.PanelUtama.Visible := False;
  MTambah.PanelUtama.Visible := False;
  MGetData.PanelUtama.Visible := False;
end;

procedure TMUtama.ClearSelectData;
begin
 MGetData.Index.SetText('');
 MGetData.IDText.SetText('');
 MGetData.NamaText.SetText('');
 MGetData.NoHPText.SetText('');
end;

end.
