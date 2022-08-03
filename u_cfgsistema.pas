unit u_cfgsistema;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils, db, Forms, Controls, Graphics, Dialogs, DBCtrls,
			MaskEdit, StdCtrls, ExtCtrls, Buttons, FileUtil;

type

			{ TFormCGFSistema }

      TFormCGFSistema = class(TForm)
						BitBtnAlterar: TBitBtn;
						BitBtnSalvar: TBitBtn;
						ButtonLogo: TButton;
						DataSourceCFGSistema: TDataSource;
						DBEditEmail : TDBEdit ;
						DBEditSite : TDBEdit ;
						DBEditCelular : TDBEdit ;
						DBEditTelefone : TDBEdit ;
						DBEditUF: TDBEdit;
						DBEditCidade: TDBEdit;
						DBEditBairro: TDBEdit;
						DBEditComplemento: TDBEdit;
						DBEditNumero: TDBEdit;
						DBEditEndereco: TDBEdit;
						DBEditNomeFantasia: TDBEdit;
						DBEditRazao: TDBEdit;
						DBEditIE: TDBEdit;
						ImageLogo: TImage;
						Label1: TLabel;
						Label10: TLabel;
						Label11: TLabel;
						Label12: TLabel;
						Label13 : TLabel ;
						Label14 : TLabel ;
						Label15 : TLabel ;
						Label16 : TLabel ;
						Label2: TLabel;
						Label3: TLabel;
						Label4: TLabel;
						Label5: TLabel;
						Label6: TLabel;
						Label7: TLabel;
						Label8: TLabel;
						Label9: TLabel;
						MaskEditCEP: TMaskEdit;
						MaskEditCNPJ: TMaskEdit;
						OpenDialogLogo: TOpenDialog;
						procedure BitBtnAlterarClick(Sender: TObject);
						procedure BitBtnSalvarClick(Sender: TObject);
						procedure ButtonLogoClick(Sender: TObject);
      procedure DataSourceCFGSistemaDataChange(Sender: TObject;Field: TField);
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
			procedure FormShow(Sender: TObject);
      procedure HabilitaCampos(cHabilita : Boolean);
      private

      public

      end;

var
      FormCGFSistema: TFormCGFSistema;

implementation
 uses
       u_DataModuleDB;
{$R *.lfm}

{ TFormCGFSistema }
procedure TFormCGFSistema.HabilitaCampos(cHabilita : Boolean);
begin
  MaskEditCNPJ.ReadOnly       := not cHabilita;
  DBEditIE.ReadOnly           := not cHabilita;
  DBEditRazao.ReadOnly        := not cHabilita;
  DBEditNomeFantasia.ReadOnly := not cHabilita;
  DBEditEndereco.ReadOnly     := not cHabilita;
  DBEditNumero.ReadOnly       := not cHabilita;
  DBEditComplemento.ReadOnly  := not cHabilita;
  DBEditBairro.ReadOnly       := not cHabilita;
  DBEditCidade.ReadOnly       := not cHabilita;
  DBEditUF.ReadOnly           := not cHabilita;
  MaskEditCEP.ReadOnly        := not cHabilita;
  DBEditTelefone.ReadOnly     := not cHabilita;
  DBEditCelular.ReadOnly      := not cHabilita;
  DBEditEmail.ReadOnly        := not cHabilita;
  DBEditSite.ReadOnly         := not cHabilita;
  BitBtnAlterar.Enabled       := not cHabilita;
  ButtonLogo.Enabled          := cHabilita;
  BitBtnSalvar.Enabled        := cHabilita;
end;

procedure TFormCGFSistema.FormClose(Sender: TObject;
			var CloseAction: TCloseAction);
begin
  DataModuleDB.SQLQueryCFGSistema.Close;
  CloseAction := caFree;
  FormCGFSistema := Nil;
end;

procedure TFormCGFSistema.DataSourceCFGSistemaDataChange(Sender: TObject;
			Field: TField);
begin
  if DataModuleDB.SQLQueryCFGSistema.RecordCount > 0 then
  begin
    MaskEditCNPJ.Text := DataModuleDB.SQLQueryCFGSistema.FieldByName('cCNPJ_CFG').AsString;
    MaskEditCEP.Text := DataModuleDB.SQLQueryCFGSistema.FieldByName('cCEP_CFG').AsString;
    if DataModuleDB.SQLQueryCFGSistema.FieldByName('cLOGO_CFG').AsString <> '' then
    begin
      ImageLogo.Picture.Jpeg.LoadFromFile(DataModuleDB.SQLQueryCFGSistema.FieldByName('cLOGO_CFG').AsString);
		end;
	end;
end;

procedure TFormCGFSistema.BitBtnAlterarClick(Sender: TObject);
begin
  HabilitaCampos(True);
  if DataModuleDB.SQLQueryCFGSistema.RecordCount > 0 then
  begin
    DataModuleDB.SQLQueryCFGSistema.Edit;
	end
  else
  begin
    DataModuleDB.SQLQueryCFGSistema.Append;
	end;
end;

procedure TFormCGFSistema.BitBtnSalvarClick(Sender: TObject);
var
  cLogo : String;
begin
  if MaskEditCNPJ.Text = '' then
  begin
    ShowMessage('Campo CPNJ é obrigatório!');
    Exit;
	end;

  if DBEditRazao.Text = '' then
  begin
    ShowMessage('Campo Razão Social é obrigatório!');
    Exit;
	end;

  if DBEditNomeFantasia.Text = '' then
  begin
    ShowMessage('Campo Nome Fantasia é obrigatório!');
    Exit;
	end;

  if DBEditEndereco.Text = '' then
  begin
    ShowMessage('Campo Endereço é obrigatório!');
    Exit;
	end;

  if DBEditNumero.Text = '' then
  begin
    ShowMessage('Campo Número é obrigatório!');
    Exit;
	end;

  if DBEditBairro.Text = '' then
  begin
    ShowMessage('Campo Bairro é obrigatório!');
    Exit;
	end;

  if DBEditCidade.Text = '' then
  begin
    ShowMessage('Campo Cidade é obrigatório!');
    Exit;
	end;

  if DBEditUF.Text = '' then
  begin
    ShowMessage('Campo UF é obrigatório!');
    Exit;
	end;

  if MaskEditCEP.Text = '' then
  begin
    ShowMessage('Campo CEP é obrigatório!');
    Exit;
	end;

  if Length(MaskEditCNPJ.Text) < 14 then
  begin
    ShowMessage('CNPJ inválido!');
    Exit;
	end;

  if Length(MaskEditCEP.Text) < 8 then
  begin
    ShowMessage('CEP inválido!');
    Exit;
	end;

  if OpenDialogLogo.FileName <> '' then
  begin
    cLogo := ExtractFileName(OpenDialogLogo.FileName);
    CopyFile(OpenDialogLogo.FileName,cLogo,[cffOverwriteFile]);
    DataModuleDB.SQLQueryCFGSistema.FieldByName('cLOGO_CFG').Value := cLogo;
	end;

  DataModuleDB.SQLQueryCFGSistema.FieldByName('cCNPJ_CFG').Value := MaskEditCNPJ.Text;
  DataModuleDB.SQLQueryCFGSistema.FieldByName('cCEP_CFG').Value := MaskEditCEP.Text;
  DataModuleDB.SQLQueryCFGSistema.Post;
  HabilitaCampos(False);
end;

procedure TFormCGFSistema.ButtonLogoClick(Sender: TObject);
begin
  OpenDialogLogo.Execute;
end;

procedure TFormCGFSistema.FormShow(Sender: TObject);
begin
  DataModuleDB.SQLQueryCFGSistema.Open;
end;

end.

