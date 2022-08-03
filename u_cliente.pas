unit u_cliente;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBGrids,
			DBCtrls, StdCtrls, Buttons;

type

			{ TFormCliente }

      TFormCliente = class(TForm)
						BitBtnCancel: TBitBtn;
						BitBtnPesquisar: TBitBtn;
						BitBtnDelete: TBitBtn;
						BitBtnEdit: TBitBtn;
						BitBtnInsert: TBitBtn;
						BitBtnSave: TBitBtn;
						DataSourceClientes: TDataSource;
						DBEditEmail: TDBEdit;
						DBEditTelefone: TDBEdit;
						DBEditCelular: TDBEdit;
						DBEditCEP: TDBEdit;
						DBEditCidade: TDBEdit;
						DBEditUF: TDBEdit;
						DBEditComplemento: TDBEdit;
						DBEditBairro: TDBEdit;
						DBEditNumero: TDBEdit;
						DBEditEndereco: TDBEdit;
						DBEditNome: TDBEdit;
						DBEditCPF: TDBEdit;
						Label1: TLabel;
						Label10: TLabel;
						Label11: TLabel;
						Label12: TLabel;
						Label13: TLabel;
						Label2: TLabel;
						Label3: TLabel;
						Label4: TLabel;
						Label5: TLabel;
						Label6: TLabel;
						Label7: TLabel;
						Label8: TLabel;
						Label9: TLabel;
						procedure BitBtnCancelClick(Sender: TObject);
						procedure BitBtnDeleteClick(Sender: TObject);
						procedure BitBtnEditClick(Sender: TObject);
      procedure BitBtnInsertClick(Sender: TObject);
			procedure BitBtnPesquisarClick(Sender: TObject);
						procedure BitBtnSaveClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
            procedure HabilitaCampos(bHabilita: Boolean);
      private

      public

      end;

var
      FormCliente: TFormCliente;

implementation
uses
      U_principal, u_DataModuleDB, u_consultacliente, u_ordemservico;
{$R *.lfm}

{ TFormCliente }

procedure TFormCliente.HabilitaCampos(bHabilita: Boolean);
begin
  DBEditCPF.ReadOnly         := not bHabilita;
  DBEditNome.ReadOnly        := not bHabilita;
  DBEditEndereco.ReadOnly    := not bHabilita;
  DBEditNumero.ReadOnly      := not bHabilita;
  DBEditComplemento.ReadOnly := not bHabilita;
  DBEditBairro.ReadOnly      := not bHabilita;
  DBEditCidade.ReadOnly      := not bHabilita;
  DBEditUF.ReadOnly          := not bHabilita;
  DBEditCEP.ReadOnly         := not bHabilita;
  DBEditTelefone.ReadOnly    := not bHabilita;
  DBEditCelular.ReadOnly     := not bHabilita;
  DBEditEmail.ReadOnly       := not bHabilita;
  BitBtnInsert.Enabled       := not bHabilita;
  BitBtnEdit.Enabled         := not bHabilita;
  BitBtnDelete.Enabled       := not bHabilita;
  BitBtnPesquisar.Enabled    := not bHabilita;
  BitBtnSave.Enabled         := bHabilita;
  BitBtnCancel.Enabled       := bHabilita;
end;

procedure TFormCliente.FormClose(Sender: TObject; var CloseAction: TCloseAction
			);
begin
  if Assigned(FormOrdemServico) then
  begin
    if    (DataModuleDB.SQLQueryClientes.Active = True)
      and (DataModuleDB.SQLQueryClientes.RecordCount > 0) then
    begin
      FormOrdemServico.MaskEditCPFCliente.Text   := DataModuleDB.SQLQueryClientes.FieldByName('cCPF_CL').AsString;
      FormOrdemServico.EditNomeCliente.Text      := DataModuleDB.SQLQueryClientes.FieldByName('cNOME_CL').AsString;
      FormOrdemServico.EditEnderecoCliente.Text  := DataModuleDB.SQLQueryClientes.FieldByName('cENDERECO_CL').AsString;
      FormOrdemServico.EditNumeroEndCliente.Text := DataModuleDB.SQLQueryClientes.FieldByName('cNUMERO_CL').AsString;
      FormOrdemServico.EditCidadeCliente.Text    := DataModuleDB.SQLQueryClientes.FieldByName('cCIDADE_CL').AsString;
      FormOrdemServico.EditUFCliente.Text        := DataModuleDB.SQLQueryClientes.FieldByName('cUF_CL').AsString;
      FormOrdemServico.EditCPFCliente.Text       := DataModuleDB.SQLQueryClientes.FieldByName('cCPF_CL').AsString;
		end;
	end;
	DataModuleDB.SQLQueryClientes.Close;
  CloseAction := caFree;
  FormCliente := Nil;
end;

procedure TFormCliente.BitBtnInsertClick(Sender: TObject);
begin
  HabilitaCampos(True);
  DataModuleDB.SQLQueryClientes.Close;
  DataModuleDB.SQLQueryClientes.Open;
  DataModuleDB.SQLQueryClientes.Append;
end;

procedure TFormCliente.BitBtnPesquisarClick(Sender: TObject);
begin
  FormConsultaCliente := TFormConsultaCliente.Create(Application);
  FormConsultaCliente.ShowModal;
end;

procedure TFormCliente.BitBtnCancelClick(Sender: TObject);
begin
  DataModuleDB.SQLQueryClientes.Cancel;
  HabilitaCampos(False);
end;

procedure TFormCliente.BitBtnDeleteClick(Sender: TObject);
begin
  if   (DataModuleDB.SQLQueryClientes.Active = False)
    or (DataModuleDB.SQLQueryClientes.RecordCount < 1) then
  begin
    ShowMessage('Sem registro para exclusão!');
    Exit;
	end;

  if MessageDlg('','Confirma a exclusão desse cliente?' ,mtConfirmation,mbYesNo,'') = mrNo then
  begin
    Exit;
	end;

  try
    DataModuleDB.SQLQueryClientes.Delete;
    ShowMessage('Registro excluido!');
	except
    ShowMessage('Registro não pode ser excluido!');
	end;
end;

procedure TFormCliente.BitBtnEditClick(Sender: TObject);
begin
  if   (DataModuleDB.SQLQueryClientes.Active = False)
    or (DataModuleDB.SQLQueryClientes.RecordCount < 1) then
  begin
    ShowMessage('Sem registro para alteração!');
    Exit;
	end;
  HabilitaCampos(True);
  DataModuleDB.SQLQueryClientes.Edit;
end;

procedure TFormCliente.BitBtnSaveClick(Sender: TObject);
begin
  DataModuleDB.SQLQueryClientes.FieldByName('cUSUARIO_CL').Value := FormPrincipal.StatusBarPrincipal.Panels[1].Text;
  DataModuleDB.SQLQueryClientes.FieldByName('cDATA_CL').Value := Now;
  try
    DataModuleDB.SQLQueryClientes.Post;
    HabilitaCampos(False);
    ShowMessage('Registro Salvo!');
	except
    ShowMessage('Erro ao tentar salvar registro, verique se o CPF já está cadastro ou se algum campo obrigatório está vazio!');
	end;
end;

end.

