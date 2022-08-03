program SistemaAutoMecanica;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms , U_principal , u_DataModuleDB , u_login , u_cfgsistema , u_usuario ,
	u_alterasenha , u_cliente , u_consultacliente , u_ordemservico ,
	u_consultaordemservico ;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
	Application .CreateForm (TFormPrincipal , FormPrincipal );
	Application .CreateForm (TDataModuleDB , DataModuleDB );
	Application .CreateForm (TFormLogin , FormLogin );
  Application.Run;
end.

