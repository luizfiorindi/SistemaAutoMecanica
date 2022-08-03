unit U_principal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
	Menus, Buttons , StdCtrls, FileUtil, zipper;

type

  { TFormPrincipal }

  TFormPrincipal = class(TForm)
				BitBtnNovoCliente: TBitBtn;
				BitBtnNovaOS: TBitBtn;
				BitBtnConsultaOS: TBitBtn;
				ImagePrincipal: TImage;
				MainMenuPrincipal: TMainMenu;
				MenuItemConsultaOS: TMenuItem;
				MenuItemBackup: TMenuItem;
				MenuItemFerramentas: TMenuItem;
				MenuItemNovaOS: TMenuItem;
				MenuItemOS: TMenuItem;
				MenuItemCliente: TMenuItem;
				MenuItemCGFSistema: TMenuItem;
				MenuItemUsuario: TMenuItem;
				MenuItemCadastro: TMenuItem;
				PanelPrincipal: TPanel;
				SaveDialogBackup : TSaveDialog ;
				StatusBarPrincipal: TStatusBar;
		procedure BitBtnConsultaOSClick (Sender : TObject );
  procedure BitBtnNovaOSClick(Sender: TObject);
  procedure BitBtnNovoClienteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
		procedure FormShow(Sender: TObject);
		procedure MenuItemBackupClick (Sender : TObject );
		procedure MenuItemCGFSistemaClick(Sender: TObject);
		procedure MenuItemClienteClick(Sender: TObject);
		procedure MenuItemConsultaOSClick (Sender : TObject );
		procedure MenuItemNovaOSClick(Sender: TObject);
		procedure MenuItemUsuarioClick (Sender : TObject );
  private

  public
    cTipoUS : String;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  u_login, u_cfgsistema, u_usuario, u_cliente, u_ordemservico, u_consultaordemservico, u_DataModuleDB;
{$R *.lfm}

{ TFormPrincipal }

procedure TFormPrincipal.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  FormPrincipal := Nil;
end;

procedure TFormPrincipal.BitBtnNovoClienteClick(Sender: TObject);
begin
  FormCliente := TFormCliente.Create(Application);
  FormCliente.ShowModal;
end;

procedure TFormPrincipal.BitBtnNovaOSClick(Sender: TObject);
begin
  FormOrdemServico := TFormOrdemServico.Create(Application);
  FormOrdemServico.ShowModal;
end;

procedure TFormPrincipal .BitBtnConsultaOSClick (Sender : TObject );
begin
  FormConsultaOrdemServico := TFormConsultaOrdemServico.Create(Application);
  FormConsultaOrdemServico.ShowModal;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  FormLogin.ShowModal;
end;

procedure TFormPrincipal .MenuItemBackupClick (Sender : TObject );
var
  cDestino  : String;
  cOrigem   : String;
begin
  if SaveDialogBackup.Execute then
  begin
   cOrigem  := ExtractFilePath(Application.ExeName) + 'banco.db';
   cDestino := ExtractFilePath(SaveDialogBackup.FileName) + 'banco.db';
   DataModuleDB.SQLite3ConnectionDB.Close;
   if CopyFile(cOrigem,cDestino,[cffOverwriteFile]) then
   begin
     ShowMessage('Arquivo salvo!');
	 end
   else
   begin
     ShowMessage('Erro ao tentar salvar o arquivo!');
	 end;
   DataModuleDB.SQLite3ConnectionDB.Open;
	end;
end;

procedure TFormPrincipal.MenuItemCGFSistemaClick(Sender: TObject);
begin
  FormCGFSistema := TFormCGFSistema.Create(Application);
  FormCGFSistema.ShowModal;
end;

procedure TFormPrincipal.MenuItemClienteClick(Sender: TObject);
begin
  FormCliente := TFormCliente.Create(Application);
  FormCliente.ShowModal;
end;

procedure TFormPrincipal .MenuItemConsultaOSClick (Sender : TObject );
begin
  FormConsultaOrdemServico := TFormConsultaOrdemServico.Create(Application);
  FormConsultaOrdemServico.ShowModal;
end;

procedure TFormPrincipal.MenuItemNovaOSClick(Sender: TObject);
begin
  FormOrdemServico := TFormOrdemServico.Create(Application);
  FormOrdemServico.ShowModal;
end;

procedure TFormPrincipal .MenuItemUsuarioClick (Sender : TObject );
begin
  FormUsuario := TFormUsuario.Create(Application);
  FormUsuario.ShowModal;
end;

end.

