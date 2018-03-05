{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.Client_test;

interface

uses
  dialogs,
  Classes, SysUtils,
  ooHTTP.Request,
  ooHTTP.Request.JSON.Mock, ooHTTP.Request.XML.Mock,
  ooHTTP.Request.Country.Mock,
  ooHTTP.Response.Stream,
  ooHTTP.Method,
  ooHTTP.Field,
  ooHTTP.Message.Body.Fields,
  ooHTTP.Client,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPClientTest = class(TTestCase)
  published
    procedure SendSimpleRequest;
    procedure SendFail;
    procedure SendXMLBodyParameter;
  end;

implementation

procedure THTTPClientTest.SendFail;
var
  Client: IHTTPClient;
  ErrorFound: Boolean;
begin
  Client := THTTPClient.New;
  ErrorFound := False;
  try
    Client.Send(nil);
  except
    ErrorFound := True;
  end;
  CheckTrue(ErrorFound);
end;

procedure THTTPClientTest.SendSimpleRequest;
var
  Request: IHTTPRequest;
  Client: IHTTPClient;
begin
  Request := THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1');
  Client := THTTPClient.New;
  Client.Send(Request);
  CheckEquals(410, Length(THTTPRequestJSONMock(Request).ResponseContent));
end;

procedure THTTPClientTest.SendXMLBodyParameter;
var
  Request: IHTTPRequest;
  Client: IHTTPClient;
// OnSendSuccess: TOnHTTPConnectionSuccess;
// OnSendFail: TOnHTTPConnectionFail;
begin
// OnSendSuccess := procedure(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream)
// begin
// CheckTrue(StatusCode = 200);
// end;
// OnSendFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
// begin
// CheckFalse(True);
// end;
  Request := THTTPRequestCountryMock.New
    ('www.oorsprong.org/websamples.countryinfo/CountryInfoService.wso/FullCountryInfo');
  THTTPMessageBodyFields(Request.Body).Fields.Add(THTTPField.New('sCountryISOCode', 'AR'));
  Client := THTTPClient.New;
  Client.Send(Request);
//  Showmessage(THTTPRequestCountryMock(Request).ResponseContent);
end;

initialization

RegisterTest(THTTPClientTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
