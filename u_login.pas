unit u_login;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, StdCtrls,
			MaskEdit;

type

			{ TFormLogin }

      TFormLogin = class(TForm)
						ButtonAlterarSenha: TButton;
						ButtonLogar: TButton;
						EditLogin: TEdit;
						EditSenha: TEdit;
						Label1: TLabel;
						Label2: TLabel;
						procedure ButtonAlterarSenhaClick(Sender: TObject);
      procedure ButtonLogarClick(Sender: TObject);
						procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
						procedure FormShow(Sender: TObject);
      private
       cValidado : String;
      public

      end;

var
      FormLogin: TFormLogin;

implementation
uses
      u_DataModuleDB, U_principal, u_alterasenha;

{$R *.lfm}

{ TFormLogin }

procedure TFormLogin.ButtonLogarClick(Sender: TObject);
begin
  if (EditLogin.Text = '') or (EditSenha.Text = '') then
  begin
    ShowMessage('Campos Login e Senha são obrigatórios!');
    Exit;
	end;

  DataModuleDB.SQLQueryScript.Active := False;
  DataModuleDB.SQLQueryScript.SQL.Text := ' SELECT *';
  DataModuleDB.SQLQueryScript.SQL.Add(    '   FROM TB_USUARIOS');
  DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE cLOGIN_US = ' + #39 + EditLogin.Text + #39);
  DataModuleDB.SQLQueryScript.SQL.Add(    '    AND cSENHA_US = ' + #39 + EditSenha.Text + #39);
  DataModuleDB.SQLQueryScript.Active := True;

  if DataModuleDB.SQLQueryScript.RecordCount < 1 then
  begin
    ShowMessage('Login ou Senha inválidos!');
    Exit;
	end;

  cValidado := '1';
  FormPrincipal.cTipoUS := DataModuleDB.SQLQueryScript.FieldByName('cTIPO_US').AsString;

  if DataModuleDB.SQLQueryScript.FieldByName('cTIPO_US').AsString = 'A' then
  begin
    FormPrincipal.StatusBarPrincipal.Panels[3].Text := 'Administrador';
	end
  else
  begin
    FormPrincipal.StatusBarPrincipal.Panels[3].Text := 'Usuário';
    FormPrincipal.MenuItemFerramentas.Visible := False;
    FormPrincipal.MenuItemCGFSistema.Visible := False;
    FormPrincipal.MenuItemUsuario.Visible := False;
	end;

	FormPrincipal.StatusBarPrincipal.Panels[1].Text := DataModuleDB.SQLQueryScript.FieldByName('cLOGIN_US').AsString;
  DataModuleDB.SQLQueryCFGSistema.Close;
  DataModuleDB.SQLQueryCFGSistema.Open;
  if   (DataModuleDB.SQLQueryCFGSistema.RecordCount > 0)
   and (DataModuleDB.SQLQueryCFGSistema.FieldByName('cLOGO_CFG').AsString <> '') then
  begin
    FormPrincipal.ImagePrincipal.Picture.Jpeg.LoadFromFile(DataModuleDB.SQLQueryCFGSistema.FieldByName('cLOGO_CFG').AsString);
	end;
	Close;
end;

procedure TFormLogin.ButtonAlterarSenhaClick(Sender: TObject);
begin
  if EditLogin.Text = '' then
  begin
    ShowMessage('Informe o Login!');
    Exit;
	end;

  if EditLogin.Text = 'ADMIN' then
  begin
    ShowMessage('Usuário ADMIN só pode ser alterado na tela de Cadastro de Usuário!');
    Exit;
	end;

  FormAlteraSenha := TFormAlteraSenha.Create(Application);
  FormAlteraSenha.ShowModal;
end;

procedure TFormLogin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if cValidado <> '1' then
  begin
    FormPrincipal.Close;
	end;
	CloseAction := caFree;
  FormLogin := Nil;
end;

procedure TFormLogin.FormShow(Sender: TObject);
begin
  EditLogin.SetFocus;
end;

end.

