unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  ooHTTP.Response.Status,
  ooHTTP.Response.Stream,
  ooHTTP.Connection,
  ooHTTP.Proxy,
  ooHTTP.Request,
  JIRA.Query.Request;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  Request: IHTTPRequest;
  Connection: IHTTPConnection;
  OnSendSuccess: TOnHTTPConnectionSuccess;
  OnSendFail: TOnHTTPConnectionFail;
begin
  OnSendSuccess := procedure(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream)
    begin

    end;
  OnSendFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
    begin

    end;
  Request := TJIRAQueryRequest.New;
  Connection := THTTPConnection.New(OnSendSuccess, OnSendFail);
  Connection.Send(Request);

end;

end.
