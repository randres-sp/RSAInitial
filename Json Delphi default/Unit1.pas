unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXJSON, Data.DBXJSONReflect,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  I, J: Integer;
  JSONValue: TJSONValue;
  JSONValueDetails: TJSONValue;
begin
  JSONArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(memo1.Lines.Text), 0) as TJSONArray;
  for I := 0 to JSONArray.Size - 1 do
  begin
    JSONObject := JSONArray.Get(I) as TJsonObject;

    //get status
    ShowMessage('Status: ' + JSonObject.Get('status').JSONValue.Value);

    //get tvshow
    JSONValue := JSonObject.Get('tvshow').JSONValue;
    for J := 0 to TJSONArray(JSONValue).Size - 1 do
    begin
      JSONValueDetails := TJSONArray(JSONValue).Get(J);
      ShowMessage('TvShow(' + TJSONPair(JSONValueDetails).JsonString.Value + '): ' + TJSONPair(JSONValueDetails).JSONValue.Value);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  JSONObject: TJSONObject;
  JSONArray: TJSONArray;
  I, J: Integer;
  JSONValue: TJSONValue;
  JSONValueDetails: TJSONValue;
  sl: TStringList;
begin
   sl := TStringList.Create;
   sl.LoadFromFile('C:\Users\Public\Documents\FIBA\FIBA Livestats\ImportFiles\'+
      '5P4ZWKB8GUQLGSNBSPTP - Copy.json');

  JSONArray := TJSONObject.ParseJSONValue(TEncoding.Default.GetBytes(sl.Text), 0) as TJSONArray;
  for I := 0 to JSONArray.Size - 1 do
  begin
    JSONObject := JSONArray.Get(I) as TJsonObject;

    //get match
    JSONValue := JSonObject.Get('match').JSONValue;
    for J := 0 to TJSONArray(JSONValue).Size - 1 do
    begin
      JSONValueDetails := TJSONArray(JSONValue).Get(J);
      ShowMessage('Match(' + TJSONPair(JSONValueDetails).JsonString.Value + '): ' + TJSONPair(JSONValueDetails).JSONValue.Value);
    end;
  end;
  sl.Free;
end;

end.
