{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  HTTP proxy definition
  @created(17/11/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooHTTP.Proxy;

interface

uses
  ooNet.Address,
  ooNet.Protocol,
  ooNet.Credential,
  ooNet.AccessPoint;

type
{$REGION 'documentation'}
{
  @abstract(HTTP proxy interface)
  Object to define a connection communication proxy
}
{$ENDREGION}
  IHTTPProxy = interface(INetAccessPoint)
    ['{71A516E7-7B88-4F4A-A92F-BF3C48EEF7AC}']
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IHTTPProxy))
  @member(Address @seealso(INetAccessPoint.Address))
  @member(Protocol @seealso(INetAccessPoint.Protocol))
  @member(Credential @seealso(INetAccessPoint.Credential))
  @member(Text @seealso(INetAccessPoint.Text))
  @member(
    Create Object constructor
    @param(AccessPoint Access point object)
  )
  @member(
    New Create a new @classname as interface
    @param(AccessPoint Access point object)
  )
}
{$ENDREGION}

  THTTPProxy = class sealed(TInterfacedObject, IHTTPProxy)
  strict private
    _AccessPoint: INetAccessPoint;
  public
    function Address: INetAddress;
    function Protocol: INetProtocol;
    function Credential: INetCredential;
    function Text: String;
    constructor Create(const AccessPoint: INetAccessPoint);
    class function New(const AccessPoint: INetAccessPoint): IHTTPProxy;
  end;

implementation

function THTTPProxy.Address: INetAddress;
begin
  Result := _AccessPoint.Address;
end;

function THTTPProxy.Protocol: INetProtocol;
begin
  Result := _AccessPoint.Protocol;
end;

function THTTPProxy.Credential: INetCredential;
begin
  Result := _AccessPoint.Credential;
end;

function THTTPProxy.Text: String;
begin
  Result := _AccessPoint.Text;
end;

constructor THTTPProxy.Create(const AccessPoint: INetAccessPoint);
begin
  _AccessPoint := AccessPoint;
end;

class function THTTPProxy.New(const AccessPoint: INetAccessPoint): IHTTPProxy;
begin
  Result := THTTPProxy.Create(AccessPoint);
end;

end.
