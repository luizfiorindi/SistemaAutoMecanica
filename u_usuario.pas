unit u_usuario;

{$mode objfpc}{$H+}

interface

uses
      Classes , SysUtils , db , Forms , Controls , Graphics , Dialogs , DBCtrls ,
			StdCtrls , Buttons , DBGrids;

type

			{ TFormUsuario }

      TFormUsuario = class(TForm)
						BitBtnInsert : TBitBtn ;
						BitBtnEdit : TBitBtn ;
						BitBtnDelete : TBitBtn ;
						BitBtnSave : TBitBtn ;
						BitBtnCancel : TBitBtn ;
						DataSourceUsuarios : TDataSource ;
						DBEditLogin : TDBEdit ;
						DBEditNome : TDBEdit ;
						DBGridUsuarios : TDBGrid ;
						DBRadioGroupTipo : TDBRadioGroup ;
						EditSenha : TEdit ;
						Label1 : TLabel ;
						Label2 : TLabel ;
						Label3 : TLabel ;
						procedure BitBtnCancelClick (Sender : TObject );
						procedure BitBtnDeleteClick (Sender : TObject );
      procedure BitBtnEditClick (Sender : TObject );
      procedure BitBtnInsertClick (Sender : TObject );
			procedure BitBtnSaveClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
						procedure FormShow (Sender : TObject );
            procedure HabilitaCampos(cHabilita : Boolean);
      private
        cTipoMetodo : String;
      public

      end;

var
      FormUsuario: TFormUsuario;

implementation
  uses
    u_DataModuleDB;
{$R *.lfm}

{ TFormUsuario }
procedure TFormUsuario.HabilitaCampos(cHabilita : Boolean);
begin
  DBEditLogin.ReadOnly      := not cHabilita;
  DBEditNome.ReadOnly       := not cHabilita;
  EditSenha.ReadOnly        := not cHabilita;
  DBRadioGroupTipo.ReadOnly := not cHabilita;
  BitBtnInsert.Enabled      := not cHabilita;
  BitBtnEdit.Enabled        := not cHabilita;
  BitBtnDelete.Enabled      := not cHabilita;
  DBGridUsuarios.Enabled    := not cHabilita;
  BitBtnSave.Enabled        := cHabilita;
  BitBtnCancel.Enabled      := cHabilita;

  if cHabilita = False then
  begin
    EditSenha.Text := '';
	end;
end;

procedure TFormUsuario.FormClose(Sender: TObject; var CloseAction: TCloseAction
			);
begin
  DataModuleDB.SQLQueryUsuarios.Close;
  CloseAction := caFree;
  FormUsuario := Nil;
end;

procedure TFormUsuario .BitBtnInsertClick (Sender : TObject );
begin
  HabilitaCampos(True);
  cTipoMetodo := 'I';
  DataModuleDB.SQLQueryUsuarios.Append;
end;

procedure TFormUsuario.BitBtnSaveClick(Sender: TObject);
begin
  if DBEditLogin.Text = '' then
  begin
    ShowMessage('Campo Login ?? obrigat??rio!');
    Exit;
	end;

  if DBEditNome.Text = '' then
  begin
    ShowMessage('Campo Nome ?? obrigat??rio!');
    Exit;
	end;

  if    (DBRadioGroupTipo.Value <> 'U')
    and (DBRadioGroupTipo.Value <> 'A') then
  begin
    ShowMessage('Campo Tipo ?? obrigat??rio!');
    Exit;
	end;

  if cTipoMetodo = 'I' then
  begin
    if EditSenha.Text = '' then
    begin
      ShowMessage('Campo Senha ?? obrigat??rio!');
      Exit;
		end;

    DataModuleDB.SQLQueryUsuarios.FieldByName('cSENHA_US').Value := EditSenha.Text;

    try
      DataModuleDB.SQLQueryUsuarios.Post;
      HabilitaCampos(False);
      ShowMessage('Registro salvo com sucesso!');
		except
      ShowMessage('Registro n??o pode ser salvo, verifique se o login digitado j?? existe!');
		end;
	end;

  if cTipoMetodo = 'U' then
  begin
    if EditSenha.Text <> '' then
    begin
      DataModuleDB.SQLQueryUsuarios.FieldByName('cSENHA_US').Value := EditSenha.Text;
    end;

    try
      DataModuleDB.SQLQueryUsuarios.Post;
      HabilitaCampos(False);
      ShowMessage('Registro alterado com sucesso!');
		except
      ShowMessage('Registro n??o pode ser alterado!');
		end;
	end;
end;

procedure TFormUsuario .BitBtnEditClick (Sender : TObject );
begin
  if DataModuleDB.SQLQueryUsuarios.RecordCount < 1 then
  begin
    ShowMessage('N??o h?? registro para altera????o!');
    Exit;
	end;

	HabilitaCampos(True);
  cTipoMetodo := 'U';
  DataModuleDB.SQLQueryUsuarios.Edit;

  if DBEditLogin.Text = 'ADMIN' then
  begin
    DBEditLogin.ReadOnly      := True;
    DBEditNome.ReadOnly       := True;
    DBRadioGroupTipo.ReadOnly := True;
	end;
end;

procedure TFormUsuario .BitBtnCancelClick (Sender : TObject );
begin
  HabilitaCampos(False);
  DataModuleDB.SQLQueryUsuarios.Cancel;
end;

procedure TFormUsuario .BitBtnDeleteClick (Sender : TObject );
begin
  if DataModuleDB.SQLQueryUsuarios.RecordCount < 1 then
  begin
    ShowMessage('N??o h?? registro para exclus??o!');
    Exit;
	end;

  if DataModuleDB.SQLQueryUsuarios.FieldByName('cLOGIN_US').AsString = 'ADMIN' then
  begin
    ShowMessage('Usu??rio ADMIN n??o pode ser exclu??do!');
    Exit;
	end;

  if MessageDlg('','Confirma a exclus??o desse usu??rio?' ,mtConfirmation,mbYesNo,'') = mrNo then
  begin
    Exit;
	end;

  DataModuleDB.SQLQueryUsuarios.Delete;
end;

procedure TFormUsuario.FormShow (Sender : TObject );
begin
  DataModuleDB.SQLQueryUsuarios.Open;
end;

end.

