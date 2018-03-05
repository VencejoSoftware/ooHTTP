{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooHTTP.RequestSend.Supervisor_test;

interface

uses
  SysUtils,
  ooHTTP.Request, ooHTTP.Request.JSON.Mock,
  ooHTTP.Connection,
  ooHTTP.RequestSend.Task, ooHTTP.RequestSend.Supervisor,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  THTTPRequestSendTaskListTest = class(TTestCase)
  published
    procedure CanCreateIsTrue;
    procedure CountIs0;
    procedure ExecuteTask;
  end;

implementation

procedure THTTPRequestSendTaskListTest.CanCreateIsTrue;
var
  RequestSendSupervisor: IHTTPRequestSendSupervisor;
begin
  RequestSendSupervisor := THTTPRequestSendTaskList.New(1);
  CheckTrue(RequestSendSupervisor.CanCreateATask);
end;

procedure THTTPRequestSendTaskListTest.CountIs0;
var
  RequestSendSupervisor: IHTTPRequestSendSupervisor;
begin
  RequestSendSupervisor := THTTPRequestSendTaskList.New(1);
  CheckEquals(0, RequestSendSupervisor.Count);
end;

procedure THTTPRequestSendTaskListTest.ExecuteTask;
var
  RequestSendSupervisor: IHTTPRequestSendSupervisor;
  Connection: IHTTPConnection;
  Request: IHTTPRequest;
  SendTask: THTTPRequestSendTask;
begin
  RequestSendSupervisor := THTTPRequestSendTaskList.New(1);
  Connection := THTTPConnection.New(nil, nil, nil);
  Request := THTTPRequestJSONMock.New('jsonplaceholder.typicode.com/posts/1');
  SendTask := THTTPRequestSendTask.Create(Connection, Request);
  RequestSendSupervisor.ExecuteTask(SendTask);
  CheckEquals(1, RequestSendSupervisor.Count);
end;

initialization

RegisterTest(THTTPRequestSendTaskListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
