{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit Country;

interface

type
  ICountry = interface
    ['{F1CF6E56-D0F5-470D-8CF4-CC49546A2E1C}']
    function Code: String;
    function Name: String;
  end;

  TCountry = class sealed(TInterfacedObject, ICountry)
  strict private
    _Code, _Name: String;
  public
    function Code: String;
    function Name: String;
    constructor Create(const Code, Name: String);
    class function New(const Code, Name: String): ICountry;
  end;

implementation

function TCountry.Code: String;
begin
  Result := _Code;
end;

function TCountry.Name: String;
begin
  Result := _Name;
end;

constructor TCountry.Create(const Code, Name: String);
begin
  _Code := Code;
  _Name := Name;
end;

class function TCountry.New(const Code, Name: String): ICountry;
begin
  Result := TCountry.Create(Code, Name);
end;

end.
