unit u_consultacliente;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls,
			Buttons, DBGrids;

type

			{ TFormConsultaCliente }

      TFormConsultaCliente = class(TForm)
						BitBtnPesquisar: TBitBtn;
						DataSourceClientes: TDataSource;
						DBGridClientes: TDBGrid;
						EditCPF: TEdit;
						EditNome: TEdit;
						GroupBoxFiltros: TGroupBox;
						Label1: TLabel;
						Label2: TLabel;
						procedure BitBtnPesquisarClick(Sender: TObject);
						procedure DBGridClientesDblClick(Sender: TObject);
						procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
      private

      public

      end;

var
      FormConsultaCliente: TFormConsultaCliente;

implementation

uses
      u_DataModuleDB, u_cliente;

{$R *.lfm}

{ TFormConsultaCliente }

procedure TFormConsultaCliente.BitBtnPesquisarClick(Sender: TObject);
begin
  DataModuleDB.SQLQueryScript.Active := False;
  DataModuleDB.SQLQueryScript.SQL.Text := ' SELECT cCPF_CL';
  DataModuleDB.SQLQueryScript.SQL.Add(    '      , cNOME_CL');
  DataModuleDB.SQLQueryScript.SQL.Add(    '   FROM TB_CLIENTES');
  DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE 1=1');
  if EditCPF.Text <> '' then
  begin
    DataModuleDB.SQLQueryScript.SQL.Add(  '    AND cCPF_CL = ' + #39 + EditCPF.Text + #39);
  end;
  if EditNome.Text <> '' then
  begin
    DataModuleDB.SQLQueryScript.SQL.Add(  '    AND cNOME_CL LIKE ' + #39 + '%' + EditNome.Text + '%' + #39);
	end;
  DataModuleDB.SQLQueryScript.SQL.Add(    '  ORDER BY cNOME_CL');
  DataModuleDB.SQLQueryScript.Active := True;

  if DataModuleDB.SQLQueryScript.RecordCount < 1 then
  begin
    ShowMessage('Nenhum registro encontrado!');
	end;
end;

procedure TFormConsultaCliente.DBGridClientesDblClick(Sender: TObject);
begin
  Close;
end;

procedure TFormConsultaCliente.FormClose(Sender: TObject;
			var CloseAction: TCloseAction);
begin
  if DataModuleDB.SQLQueryScript.RecordCount > 0 then
  begin
    if Assigned(FormCliente) then
    begin
      DataModuleDB.SQLQueryClientes.Active := False;
      DataModuleDB.SQLQueryClientes.Filtered := False;
      DataModuleDB.SQLQueryClientes.Filter := 'cCPF_CL = ' + #39 + DataModuleDB.SQLQueryScript.FieldByName('cCPF_CL').AsString + #39;
      DataModuleDB.SQLQueryClientes.Filtered := True;
      DataModuleDB.SQLQueryClientes.Active := True;
		end;
	end;
	DataModuleDB.SQLQueryScript.Active := False;
  CloseAction := caFree;
  FormConsultaCliente := Nil;
end;

end.

