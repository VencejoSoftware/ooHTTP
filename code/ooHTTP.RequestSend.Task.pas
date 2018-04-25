{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Task to send a request in parallel
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.RequestSend.Task;

interface

uses
{$IFDEF FPC}
  SyncObjs,
{$ELSE}
  Windows,
{$ENDIF}
  Classes,
  ooHTTP.Request,
  ooHTTP.Connection;

type
{$REGION 'documentation'}
{
  @abstract(Event executed when the task call destructor)
  @param(ID Task identifier)
}
{$ENDREGION}
  THTTPOnRequestSendTaskFinish = reference to procedure(const ID: Cardinal);

{$REGION 'documentation'}
{
  @abstract(Task to send request)
  @member(Execute Override TThread.Execute)
  @member(
    ChangeOnDestroy Change the destroy event
    @param(OnDestroy Event executed on destroy)
  )
  @member(
    Create Object constructor
    @param(Connection Connection object to use)
    @param(Request Request to send)
  )
  @member(Destroy Object destructor);
}
{$ENDREGION}

  THTTPRequestSendTask = class sealed(TThread)
  strict private
    _CriticalSection: TRTLCriticalSection;
    _OnDestroy: THTTPOnRequestSendTaskFinish;
    _Connection: IHTTPConnection;
    _Request: IHTTPRequest;
  protected
    procedure Execute; override;
  public
    procedure ChangeOnDestroy(const OnDestroy: THTTPOnRequestSendTaskFinish);
    constructor Create(const Connection: IHTTPConnection; const Request: IHTTPRequest); reintroduce;
    destructor Destroy; override;
  end;

  ver de crear timeout o expiracion de request

implementation

procedure THTTPRequestSendTask.Execute;
begin
  EnterCriticalSection(_CriticalSection);
  try
    _Connection.Send(_Request);
  finally
    LeaveCriticalSection(_CriticalSection);
  end;
end;

procedure THTTPRequestSendTask.ChangeOnDestroy(const OnDestroy: THTTPOnRequestSendTaskFinish);
begin
  _OnDestroy := OnDestroy;
end;

constructor THTTPRequestSendTask.Create(const Connection: IHTTPConnection; const Request: IHTTPRequest);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  InitializeCriticalSection(_CriticalSection);
  _Connection := Connection;
  _Request := Request;
end;

destructor THTTPRequestSendTask.Destroy;
begin
  DeleteCriticalSection(_CriticalSection);
  if Assigned(_OnDestroy) then
    _OnDestroy(ThreadID);
  inherited;
end;

end.
