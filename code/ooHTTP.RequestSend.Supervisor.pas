{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Request send task supervisor
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.RequestSend.Supervisor;

interface

uses
  SysUtils,
  Generics.Collections,
  ooHTTP.RequestSend.Task;

type
{$REGION 'documentation'}
{
  @abstract(Subtype for maximun concurrent tasks)
}
{$ENDREGION}
  THTTPSupervisorMaxTasks = 1 .. 8;

{$REGION 'documentation'}
{
  @abstract(HTTP Send request tasks supervisor)
  @member(
    CanCreateATask Checks for free slots to create a new task
    @return(@true if has free slots, @false if not)
  )
  @member(Count Returns the number of active tasks)
  @member(
    ExecuteTask Add a task to the list and immediately execute
    @param(Taks Task object)
  )
}
{$ENDREGION}

  IHTTPRequestSendSupervisor = interface
    ['{E60C9F7C-3281-4FA1-8A89-7AC5CC9435A3}']
    function CanCreateATask: Boolean;
    function Count: Integer;
    procedure ExecuteTask(const Task: THTTPRequestSendTask);
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPRequestSendSupervisor))
  @member(CanCreateATask @seealso(IHTTPRequestSendSupervisor.CanCreateATask))
  @member(Count @seealso(IHTTPRequestSendSupervisor.Count))
  @member(ExecuteTask @seealso(IHTTPRequestSendSupervisor.ExecuteTask))
  @member(
    FindByID Find task by his identifier
    @param(ID The task identifier)
    @return(Task object)
  )
  @member(
    IsRunning Checks if exists an active task
    @return(@true if has active task, @false if not)
  )
  @member(
    OnRequestSendTaskFinish Event handler for task finish callback
    @param(ID Task identifier to remove)
  )
  @member(WaitForExecutions Wait for all running tasks)
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

  THTTPRequestSendTaskList = class sealed(TInterfacedObject, IHTTPRequestSendSupervisor)
  strict private
    _Lock: TMultiReadExclusiveWriteSynchronizer;
    _List: TList<THTTPRequestSendTask>;
    _ConcurrentTasks: THTTPSupervisorMaxTasks;
  private
    function FindByID(const ID: Cardinal): THTTPRequestSendTask;
    function IsRunning: Boolean;
    procedure OnRequestSendTaskFinish(const ID: Cardinal);
    procedure WaitForExecutions;
  public
    function Count: Integer;
    function CanCreateATask: Boolean;
    procedure ExecuteTask(const Task: THTTPRequestSendTask);
    constructor Create(const ConcurrentTasks: THTTPSupervisorMaxTasks);
    destructor Destroy; override;
    class function New(const ConcurrentTasks: THTTPSupervisorMaxTasks = 1): IHTTPRequestSendSupervisor;
  end;

implementation

procedure THTTPRequestSendTaskList.OnRequestSendTaskFinish(const ID: Cardinal);
begin
  _Lock.BeginWrite;
  try
    _List.Remove(FindByID(ID));
  finally
    _Lock.EndWrite;
  end;
end;

procedure THTTPRequestSendTaskList.ExecuteTask(const Task: THTTPRequestSendTask);
begin
  _Lock.BeginWrite;
  try
    _List.Add(Task);
  finally
    _Lock.EndWrite;
  end;
  Task.ChangeOnDestroy(OnRequestSendTaskFinish);
  Task.Start;
end;

function THTTPRequestSendTaskList.CanCreateATask: Boolean;
begin
  Result := Count < _ConcurrentTasks;
end;

function THTTPRequestSendTaskList.Count: Integer;
begin
  _Lock.BeginRead;
  try
    Result := _List.Count;
  finally
    _Lock.EndRead;
  end;
end;

procedure THTTPRequestSendTaskList.WaitForExecutions;
begin
  while IsRunning do
    Sleep(100);
end;

function THTTPRequestSendTaskList.FindByID(const ID: Cardinal): THTTPRequestSendTask;
var
  Task: THTTPRequestSendTask;
begin
  Result := nil;
  _Lock.BeginRead;
  try
    for Task in _List do
      if Task.ThreadID = ID then
        Exit(Task);
  finally
    _Lock.EndRead;
  end;
end;

function THTTPRequestSendTaskList.IsRunning: Boolean;
begin
  Result := Count > 0;
end;

constructor THTTPRequestSendTaskList.Create(const ConcurrentTasks: THTTPSupervisorMaxTasks);
begin
  _Lock := TMultiReadExclusiveWriteSynchronizer.Create;
  _List := TList<THTTPRequestSendTask>.Create;
  _ConcurrentTasks := ConcurrentTasks;
end;

destructor THTTPRequestSendTaskList.Destroy;
begin
  WaitForExecutions;
  _Lock.Free;
  _List.Free;
  inherited;
end;

class function THTTPRequestSendTaskList.New(const ConcurrentTasks: THTTPSupervisorMaxTasks): IHTTPRequestSendSupervisor;
begin
  Result := THTTPRequestSendTaskList.Create(ConcurrentTasks);
end;

end.
