{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program demo;

uses
  Forms,
  Main.Form in '..\code\form\Main.Form.pas' {MainForm};

{$R *.res}

begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.
