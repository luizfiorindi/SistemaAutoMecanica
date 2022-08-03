unit u_alterasenha;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

			{ TFormAlteraSenha }

      TFormAlteraSenha = class(TForm)
						ButtonAlterarSenha: TButton;
						EditSenhaAtual: TEdit;
						EditSenhaNova: TEdit;
						EditSenhaNovaConf: TEdit;
						Label1: TLabel;
						Label2: TLabel;
						Label3: TLabel;
						procedure ButtonAlterarSenhaClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
      private

      public

      end;

var
      FormAlteraSenha: TFormAlteraSenha;

implementation
  uses
        u_login, u_DataModuleDB;

{$R *.lfm}

{ TFormAlteraSenha }

procedure TFormAlteraSenha.FormClose(Sender: TObject;
			var CloseAction: TCloseAction);
begin
  DataModuleDB.SQLQueryScript.Active := False;
  CloseAction := caFree;
  FormAlteraSenha := Nil;
end;

procedure TFormAlteraSenha.ButtonAlterarSenhaClick(Sender: TObject);
var
  cLogin: String;
begin
  DataModuleDB.SQLQueryScript.Active := False;
  DataModuleDB.SQLQueryScript.SQL.Text := ' SELECT *';
  DataModuleDB.SQLQueryScript.SQL.Add(    '   FROM TB_USUARIOS');
  DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE cLOGIN_US = ' + #39 + FormLogin.EditLogin.Text + #39);
  DataModuleDB.SQLQueryScript.Active := True;

  if DataModuleDB.SQLQueryScript.RecordCount < 1 then
  begin
    ShowMessage('Login não encontrado!');
    FormLogin.EditLogin.SetFocus;
    Close;
	end
  else
  begin
    cLogin := DataModuleDB.SQLQueryScript.FieldByName('cLOGIN_US').AsString;

    if DataModuleDB.SQLQueryScript.FieldByName('cSENHA_US').AsString <> EditSenhaAtual.Text then
    begin
      ShowMessage('Senha Atual inválida!');
      Exit;
		end;

    if EditSenhaNova.Text = '' then
    begin
      ShowMessage('Campo Senha Nova é obrigatório!');
      Exit;
    end;

    if EditSenhaNova.Text <> EditSenhaNovaConf.Text then
    begin
      ShowMessage('Campos Nova Senha e Repita Nova Senha devem ser iguais!');
      Exit;
		end;

    DataModuleDB.SQLQueryScript.Active := False;
    DataModuleDB.SQLQueryScript.SQL.Text := ' UPDATE TB_USUARIOS';
    DataModuleDB.SQLQueryScript.SQL.Add(    '    SET cSENHA_US = ' + #39 + EditSenhaNova.Text + #39);
    DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE cLOGIN_US = ' + #39 + cLogin + #39);
    DataModuleDB.SQLQueryScript.ExecSQL;
    DataModuleDB.SQLTransaction.Commit;

    ShowMessage('Senha alterada com sucesso!');
    FormLogin.EditSenha.SetFocus;
    Close;
	end;
end;

end.

