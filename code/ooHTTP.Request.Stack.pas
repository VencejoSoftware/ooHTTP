{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Stack for HTTP requests
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Request.Stack;

interface

uses
  SysUtils,
  Generics.Collections,
  ooHTTP.Request;

type
{$REGION 'documentation'}
{
  @abstract(Interface for HTTP stack requests)
  HTTP address to define a net location
  @member(
    Push Add a new request to FIFO list
    @param(Request Request object)
  )
  @member(
    Pop Return the old request in the list
    @return(Request object)
  )
  @member(Count Returns the number of request in the stack)
  @member(
    IsEmpty Checks if the stack not has items
    @return(@true if the list not has items, @false is has items)
  )
}
{$ENDREGION}
  IHTTPRequestStack = interface
    ['{1741422B-2319-4104-81F0-7E74FBF9D5E0}']
    procedure Push(const Request: IHTTPRequest);
    function Pop: IHTTPRequest;
    function Count: Integer;
    function IsEmpty: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPRequestStack))
  @member(Push @seealso(IHTTPRequestStack.Push))
  @member(Pop @seealso(IHTTPRequestStack.Pop))
  @member(Count @seealso(IHTTPRequestStack.Count))
  @member(IsEmpty @seealso(IHTTPRequestStack.IsEmpty))
  @member(Create Object constructor)
  @member(Destroy Object destructor)
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  THTTPRequestStack = class sealed(TInterfacedObject, IHTTPRequestStack)
  strict private
    _List: TList<IHTTPRequest>;
    _Lock: TMultiReadExclusiveWriteSynchronizer;
  public
    function Pop: IHTTPRequest;
    function Count: Integer;
    function IsEmpty: Boolean;
    procedure Push(const Request: IHTTPRequest);
    constructor Create;
    destructor Destroy; override;
    class function New: IHTTPRequestStack;
  end;

implementation

function THTTPRequestStack.Count: Integer;
begin
  _Lock.BeginRead;
  try
    Result := _List.Count;
  finally
    _Lock.EndRead;
  end;
end;

function THTTPRequestStack.IsEmpty: Boolean;
begin
  _Lock.BeginRead;
  try
    Result := Count < 1;
  finally
    _Lock.EndRead;
  end;
end;

function THTTPRequestStack.Pop: IHTTPRequest;
begin
  if IsEmpty then
    Result := nil
  else
  begin
    _Lock.BeginRead;
    try
      Result := _List.First;
    finally
      _Lock.EndRead;
    end;
    _Lock.BeginWrite;
    try
      _List.Delete(0);
    finally
      _Lock.EndWrite;
    end;
  end;
end;

procedure THTTPRequestStack.Push(const Request: IHTTPRequest);
begin
  _Lock.BeginWrite;
  try
    _List.Add(Request);
  finally
    _Lock.EndWrite;
  end;
end;

constructor THTTPRequestStack.Create;
begin
  _List := TList<IHTTPRequest>.Create;
  _Lock := TMultiReadExclusiveWriteSynchronizer.Create;
end;

destructor THTTPRequestStack.Destroy;
begin
  _Lock.Free;
  _List.Free;
  inherited;
end;

class function THTTPRequestStack.New: IHTTPRequestStack;
begin
  Result := THTTPRequestStack.Create;
end;

end.
