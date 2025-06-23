unit ugetdata;

{$mode delphi}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, AndroidWidget, Laz_And_Controls;
  
type

  { TMGetData }

  TMGetData = class(jForm)
    IDText: jTextView;
    Index: jTextView;
    ListContact: jListView;
    NamaText: jTextView;
    NoHPText: jTextView;
    PanelUtama: jPanel;
    procedure ListContactClickItem(Sender: TObject; itemIndex: integer;
      itemCaption: string);
  private
    {private declarations}
  public
    {public declarations}

  end;

var
  MGetData: TMGetData;

  
implementation
  
  
{$R *.lfm}
  

  
{ TMGetData }

procedure TMGetData.ListContactClickItem(Sender: TObject; itemIndex: integer;
  itemCaption: string);
begin
  Index.SetText(IntToStr(itemIndex));
  IDText.SetText(ListContact.GetItemText(itemIndex).split('|')[0]);
  NamaText.SetText(ListContact.GetItemText(itemIndex).split('|')[1]);
  NoHPText.SetText(ListContact.GetItemText(itemIndex).split('|')[2]);
end;

end.
