{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Client to send requests in parallel tasks
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Client.Parallel;

interface

uses
  Classes,
  ooHTTP.Proxy,
  ooHTTP.Request,
  ooHTTP.Request.Stack,
  ooHTTP.Response, ooHTTP.Response.Stream,
  ooHTTP.Connection,
  ooHTTP.Client,
  ooHTTP.RequestSend.Task, ooHTTP.RequestSend.Supervisor;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPClient))
  Client with parallel tasks capabilities
  @member(ChangeProxy @seealso(IHTTPClient.ChangeProxy))
  @member(
    Send Add request into FIFO list and tryrun if can
    @seealso(IHTTPClient.Send)
  )
  @member(
    TryRun Checks if has free slots to run a new task with the most older request
  )
  @member(
    OnSendFail Callback event when connection send fails
    @param(Request Request object)
    @param(ErrorCode Error code identification)
    @param(Error Message error)
  )
  @member(
    OnSendSuccess Callback event when connection send success
    @param(Request Request object)
    @param(StatusCode Response status code)
    @param(Stream Response data)
  )
  @member(
    Create Object constructor
    @param(ConcurrentTasks Maximun of concurrent tasks)
  )
  @member(
    New Create a new @classname as interface
    @param(ConcurrentTasks Maximun of concurrent tasks)
  )
}
{$ENDREGION}
  THTTPClientParallel = class sealed(TInterfacedObject, IHTTPClient)
  strict private
    _Proxy: IHTTPProxy;
    _RequestStack: IHTTPRequestStack;
    _SendSupervisor: IHTTPRequestSendSupervisor;
  private
    procedure OnSendFail(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String);
    procedure OnSendSuccess(const Request: IHTTPRequest; const StatusCode: Integer; const Stream: TStream);
    procedure TryRun;
  public
    procedure ChangeProxy(const Proxy: IHTTPProxy);
    procedure Send(const Request: IHTTPRequest);
    constructor Create(const ConcurrentTasks: THTTPSupervisorMaxTasks);
    class function New(const ConcurrentTasks: THTTPSupervisorMaxTasks = 1): IHTTPClient;
  end;

implementation

procedure THTTPClientParallel.OnSendSuccess(const Request: IHTTPRequest; const StatusCode: Integer;
  const Stream: TStream);
var
  Response: IHTTPResponseStream;
begin
  Response := THTTPResponseStream.New(THTTPResponse.New(StatusCode), Stream);
  Request.ResolveResponse(Response);
end;

procedure THTTPClientParallel.OnSendFail(const Request: IHTTPRequest; const ErrorCode: Integer; const Error: String);
begin
  Request.ResolveFail(ErrorCode, Error);
end;

procedure THTTPClientParallel.ChangeProxy(const Proxy: IHTTPProxy);
begin
  _Proxy := Proxy;
end;

procedure THTTPClientParallel.TryRun;
var
  Connection: IHTTPConnection;
  Request: IHTTPRequest;
  SendTask: THTTPRequestSendTask;
begin
  if not _SendSupervisor.CanCreateATask then
    Exit;
  Request := _RequestStack.Pop;
  if not Assigned(Request) then
    Exit;
  Connection := THTTPConnection.New(OnSendSuccess, OnSendFail, _Proxy);
  SendTask := THTTPRequestSendTask.Create(Connection, Request);
  _SendSupervisor.ExecuteTask(SendTask);
end;

procedure THTTPClientParallel.Send(const Request: IHTTPRequest);
begin
  _RequestStack.Push(Request);
  TryRun;
end;

constructor THTTPClientParallel.Create(const ConcurrentTasks: THTTPSupervisorMaxTasks);
begin
  _SendSupervisor := THTTPRequestSendTaskList.New(ConcurrentTasks);
  _RequestStack := THTTPRequestStack.New;
end;

class function THTTPClientParallel.New(const ConcurrentTasks: THTTPSupervisorMaxTasks): IHTTPClient;
begin
  Result := THTTPClientParallel.Create(ConcurrentTasks);
end;

end.
