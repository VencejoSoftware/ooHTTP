{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.RequestSend.Task_test;

interface

uses
  Classes, SysUtils,
  ooHTTP.Request, ooHTTP.Request.JSON.Mock,
  ooHTTP.Connection,
  ooHTTP.RequestSend.Task,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPRequestSendTaskTest = class(TTestCase)
  published
    procedure SendWithOutDestroyEvent;
    procedure SendCheckDestroyEvent;
  end;

implementation

procedure THTTPRequestSendTaskTest.SendCheckDestroyEvent;
var
  Request: IHTTPRequest;
  Connection: IHTTPConnection;
  Client: THTTPRequestSendTask;
  OnSuccess: TOnHTTPConnectionSuccess;
  OnFail: TOnHTTPConnectionFail;
  OnThreadDestroy: THTTPOnRequestSendTaskFinish;
begin
  Request := THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1');
  OnSuccess := procedure(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream)
    begin
      CheckTrue(True);
    end;
  OnFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
    begin
      CheckTrue(False);
    end;
  OnThreadDestroy := procedure(const ID: Cardinal)
    begin
      CheckEquals(ID, Client.ThreadID);
    end;
  Connection := THTTPConnection.New(OnSuccess, OnFail, nil);
  Client := THTTPRequestSendTask.Create(Connection, Request);
  Client.ChangeOnDestroy(OnThreadDestroy);
  Client.Start;
  CheckTrue(Assigned(Client));
end;

procedure THTTPRequestSendTaskTest.SendWithOutDestroyEvent;
var
  Request: IHTTPRequest;
  Connection: IHTTPConnection;
  Client: THTTPRequestSendTask;
  OnSuccess: TOnHTTPConnectionSuccess;
  OnFail: TOnHTTPConnectionFail;
begin
  Request := THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1');
  OnSuccess := procedure(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream)
    begin
      CheckTrue(True);
    end;
  OnFail := procedure(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String)
    begin
      CheckTrue(False);
    end;
  Connection := THTTPConnection.New(OnSuccess, OnFail, nil);
  Client := THTTPRequestSendTask.Create(Connection, Request);
  Client.Start;
  CheckTrue(Assigned(Client));
end;

initialization

RegisterTest(THTTPRequestSendTaskTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
