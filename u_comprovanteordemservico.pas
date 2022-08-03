unit u_comprovanteordemservico ;

{$mode objfpc}{$H+}

interface

uses
    Classes , SysUtils , db , Forms , Controls , Graphics , Dialogs , ExtCtrls ,
		LazHelpHTML , LR_Class , LR_View , LR_E_HTM , LR_PGrid , LR_Desgn , LR_DBSet ,
		LR_DSet , SynHighlighterHTML, DBCtrls;

type

		{ TFormComprovanteOrdemServico }

    TFormComprovanteOrdemServico = class(TForm )
				DataSourceComprovanteOS : TDataSource ;
				DataSourceItensComprovanteOS : TDataSource ;
				DataSourceDadosEmpresa : TDataSource ;
				frReportComprovanteOS : TfrReport ;
				procedure FormClose (Sender : TObject ; var CloseAction : TCloseAction
						);
				procedure FormShow (Sender : TObject );
    private

    public

    end;

var
    FormComprovanteOrdemServico : TFormComprovanteOrdemServico ;

implementation

 uses
     u_DataModuleDB;

{$R *.lfm}

{ TFormComprovanteOrdemServico }

procedure TFormComprovanteOrdemServico .FormClose (Sender : TObject ;
		var CloseAction : TCloseAction );
begin
  CloseAction := caFree;
  FormComprovanteOrdemServico := Nil;
end;

procedure TFormComprovanteOrdemServico .FormShow (Sender : TObject );
begin
  if DataModuleDB.SQLQueryCFGSistema.Active = False then
  begin
    DataModuleDB.SQLQueryCFGSistema.Active := True;
	end;

  frReportComprovanteOS.LoadFromFile('ComprovanteOS.lrf');
  frReportComprovanteOS.ShowReport;
end;

end.

