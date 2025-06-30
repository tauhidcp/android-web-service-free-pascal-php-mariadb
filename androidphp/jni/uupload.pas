unit uupload;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls, downloadservice,
  uploadservice, opendialog, intentmanager, And_jni;
  
type

  { TMUpload }

  TMUpload = class(jForm)
    BPilih: jButton;
    BUpload: jButton;
    BDownload: jButton;
    DownloadService1: jDownloadService;
    EPathFile: jEditText;
    ENamaFile: jEditText;
    HttpClient1: jHttpClient;
    IntentManager1: jIntentManager;
    Judul: jTextView;
    PanelAtas: jPanel;
    PanelUtama: jPanel;
    TextOutput: jTextView;
    procedure BDownloadClick(Sender: TObject);
    procedure BPilihClick(Sender: TObject);
    procedure BUploadClick(Sender: TObject);
    procedure HttpClient1UploadFinished(Sender: TObject;
      connectionStatusCode: integer; responseMessage: string; fileName: string);

  private
    {private declarations}
  public
    {public declarations}
    procedure OpenFile;
  end;

var
  MUpload: TMUpload;
  filepath : String;
  namafile : String;
  Upload : Boolean;

  
implementation

uses uutama;
  
  
{$R *.lfm}
  

  
{ TMUpload }

procedure TMUpload.BUploadClick(Sender: TObject);
begin
 if not (ENamaFile.Text='') then
 begin
 HttpClient1.UploadFile(MUtama.EServerIP.Text+'/webapi/uploadfile.php', EPathFile.Text, 'fileupload');
 Upload:=True;
 end;
end;

procedure TMUpload.HttpClient1UploadFinished(Sender: TObject;
  connectionStatusCode: integer; responseMessage: string; fileName: string);
begin
 ShowMessage('Upload Berhasil');
end;

procedure TMUpload.OpenFile;
begin
 IntentManager1.SetAction('android.intent.action.OPEN_DOCUMENT');
 IntentManager1.SetMimeType('*/*');
 IntentManager1.StartActivityForResult(1001);
end;

procedure TMUpload.BPilihClick(Sender: TObject);
begin
 OpenFile;
end;

procedure TMUpload.BDownloadClick(Sender: TObject);
begin
 if (Upload=True) then
 begin
                 // Save File to : Android\data\id.tauhidslab.androidphp.androidphp\files\Download
 DownloadService1.SaveToFile(Self.GetEnvironmentDirectoryPath(dirDownloads), ENamaFile.Text);
 DownloadService1.Start(MUtama.EServerIP.Text+'/webapi/upload/'+ENamaFile.Text,'id.tauhidslab.androidphp.androidphp.DOWNLOAD_RECEIVER');
 TextOutput.Text:='Berhasil Download File '+sLineBreak+'Location : '+GetEnvironmentDirectoryPath(dirDownloads)+'/'+ENamaFile.Text;
 TextOutput.Visible:=True;
 end;
end;

end.
