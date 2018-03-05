{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Connection_test;

interface

uses
  Classes, SysUtils,
  ooHTTP.Request,
  ooHTTP.Request.JSON.Mock,
  ooHTTP.Request.XML.Mock,
  ooHTTP.Response.Status,
  ooHTTP.Response.Stream,
  ooHTTP.Connection,
  ooHTTP.Proxy,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPConnectionTest = class(TTestCase)
  published
    procedure SendOKJSON;
    procedure SendOKXML;
    procedure SendFail;
  end;

implementation

procedure THTTPConnectionTest.SendFail;
var
  HTTPConnection: IHTTPConnection;
  OnHTTPConnectionSuccess: TOnHTTPConnectionSuccess;
  OnHTTPConnectionFail: TOnHTTPConnectionFail;
begin
  OnHTTPConnectionSuccess := procedure(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream)
    begin
      CheckFalse(True);
    end;
  OnHTTPConnectionFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
    begin
      CheckTrue(True);
    end;
  HTTPConnection := THTTPConnection.New(OnHTTPConnectionSuccess, OnHTTPConnectionFail);
  HTTPConnection.Send(nil);
end;

procedure THTTPConnectionTest.SendOKJSON;
var
  Request: IHTTPRequest;
  Connection: IHTTPConnection;
  OnSendSuccess: TOnHTTPConnectionSuccess;
  OnSendFail: TOnHTTPConnectionFail;
begin
  OnSendSuccess := procedure(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream)
    begin
      CheckTrue(StatusCode = 200);
    end;
  OnSendFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
    begin
      CheckFalse(True);
    end;
  Request := THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1');
  Connection := THTTPConnection.New(OnSendSuccess, OnSendFail);
  Connection.Send(Request);
end;

procedure THTTPConnectionTest.SendOKXML;
var
  Request: IHTTPRequest;
  Connection: IHTTPConnection;
  OnSendSuccess: TOnHTTPConnectionSuccess;
  OnSendFail: TOnHTTPConnectionFail;
begin
  OnSendSuccess := procedure(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream)
    begin
      CheckTrue(StatusCode = 200);
    end;
  OnSendFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
    begin
      CheckFalse(True);
    end;
  Request := THTTPRequestXMLMock.New('www.webservicex.net/country.asmx/GetCountries' );
  Connection := THTTPConnection.New(OnSendSuccess, OnSendFail);
  Connection.Send(Request);
end;

initialization

RegisterTest(THTTPConnectionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
