unit u_ordemservico;

{$mode objfpc}{$H+}

interface

uses
      Classes , SysUtils , db , Forms , Controls , Graphics , Dialogs ,
			MaskEdit , StdCtrls , Buttons , DBGrids , DBCtrls , Menus , LazHelpHTML, LCLIntf;

type

			{ TFormOrdemServico }

      TFormOrdemServico = class(TForm)
					BitBtnImprimirOS : TBitBtn ;
						BitBtnCadastrarCliente: TBitBtn;
						BitBtnCancelOS: TBitBtn;
						BitBtnDeleteOS: TBitBtn;
						BitBtnEditOS: TBitBtn;
						BitBtnIncluirServicoPecaIOS: TBitBtn;
						BitBtnInsertOS: TBitBtn;
						BitBtnPesquisarOS: TBitBtn;
						BitBtnSaveOS: TBitBtn;
						ButtonAddServicoPeca: TButton;
						DataSourceItensOS : TDataSource ;
						DataSourceServicosPecas : TDataSource ;
						DBGridItensOS: TDBGrid;
						DBLookupComboBoxServicoPecaIOS: TDBLookupComboBox;
						EditCPFCliente : TEdit ;
						EditQuantidadeIOS: TEdit;
						EditValorUnitarioIOS: TEdit;
						EditPlacaVeiculo: TEdit;
						EditFabricanteVeiculo: TEdit;
						EditModeloVeiculo: TEdit;
						EditUsuarioAberturaOS: TEdit;
						EditUsuarioFinalizaOS: TEdit;
						EditEnderecoCliente: TEdit;
						EditNumeroEndCliente: TEdit;
						EditCidadeCliente: TEdit;
						EditUFCliente: TEdit;
						EditNumeroOS: TEdit;
						EditNomeCliente: TEdit;
						GroupBoxItensOS: TGroupBox;
						GroupBoxDadosVeiculo: TGroupBox;
						GroupBoxDadosOS: TGroupBox;
						GroupBoxDadosCliente: TGroupBox;
						Label1: TLabel;
						Label10: TLabel;
						Label11: TLabel;
						Label12: TLabel;
						Label13: TLabel;
						Label14: TLabel;
						Label15: TLabel;
						Label16: TLabel;
						Label17: TLabel;
						Label18: TLabel;
						Label19: TLabel;
						Label2: TLabel;
						Label20: TLabel;
						LabelValorTotalOS: TLabel;
						Label3: TLabel;
						Label4: TLabel;
						Label5: TLabel;
						Label6: TLabel;
						Label7: TLabel;
						Label8: TLabel;
						Label9: TLabel;
						MaskEditDataFinalizaOS: TMaskEdit;
						MaskEditDataAberturaOS: TMaskEdit;
						MaskEditCPFCliente: TMaskEdit;
						MemoDescricaoOS: TMemo;
						MenuItemExcluir : TMenuItem ;
						PopupMenuItensOS : TPopupMenu ;
						procedure BitBtnCadastrarClienteClick(Sender: TObject);
      procedure BitBtnCancelOSClick(Sender: TObject);
			procedure BitBtnDeleteOSClick (Sender : TObject );
			procedure BitBtnEditOSClick (Sender : TObject );
			procedure BitBtnImprimirOSClick (Sender : TObject );
			procedure BitBtnIncluirServicoPecaIOSClick (Sender : TObject );
      procedure BitBtnInsertOSClick(Sender: TObject);
			procedure BitBtnPesquisarOSClick (Sender : TObject );
			procedure BitBtnSaveOSClick (Sender : TObject );
			procedure ButtonAddServicoPecaClick (Sender : TObject );
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
			procedure FormShow (Sender : TObject );
      procedure HabilitaCampos(bHabilita: Boolean; cNova: String);
			procedure MaskEditCPFClienteExit(Sender: TObject);
      procedure CalculaValorTotal();
			procedure MenuItemExcluirClick (Sender : TObject );
      procedure ConsultaOS(cCODIGO : String);

      private
        cMetodo : String;
      public

      end;

var
      FormOrdemServico: TFormOrdemServico;

implementation
uses
      U_principal, u_DataModuleDB, u_cliente, u_consultaordemservico, u_comprovanteordemservico;

{$R *.lfm}

{ TFormOrdemServico }

procedure TFormOrdemServico.HabilitaCampos(bHabilita: Boolean; cNova: String);
begin
  MaskEditCPFCliente.ReadOnly    := not bHabilita;
  MemoDescricaoOS.ReadOnly       := not bHabilita;
  EditFabricanteVeiculo.ReadOnly := not bHabilita;
  EditModeloVeiculo.ReadOnly     := not bHabilita;
  EditPlacaVeiculo.ReadOnly      := not bHabilita;
  BitBtnPesquisarOS.Enabled      := not bHabilita;
  BitBtnInsertOS.Enabled         := not bHabilita;
  BitBtnEditOS.Enabled           := not bHabilita;
  BitBtnDeleteOS.Enabled         := not bHabilita;
  BitBtnCadastrarCliente.Enabled := bHabilita;
  BitBtnSaveOS.Enabled           := bHabilita;
  BitBtnCancelOS.Enabled         := bHabilita;

  if cNova = '1' then
  begin
    MaskEditCPFCliente.Text                 := '';
    EditNomeCliente.Text                    := '';
    EditEnderecoCliente.Text                := '';
    EditNumeroEndCliente.Text               := '';
    EditCidadeCliente.Text                  := '';
    EditUFCliente.Text                      := '';
    EditNumeroOS.Text                       := '';
    MaskEditDataAberturaOS.Text             := '';
    MaskEditDataFinalizaOS.Text             := '';
    EditUsuarioAberturaOS.Text              := '';
    EditUsuarioFinalizaOS.Text              := '';
    MemoDescricaoOS.Text                    := '';
    EditFabricanteVeiculo.Text              := '';
    EditModeloVeiculo.Text                  := '';
    EditPlacaVeiculo.Text                   := '';
    DBLookupComboBoxServicoPecaIOS.KeyValue := Null;
    EditQuantidadeIOS.Text                  := '';
    EditValorUnitarioIOS.Text               := '';
    DataModuleDB.SQLQueryConsultaItensOS.Close;
	end;
end;

procedure TFormOrdemServico.CalculaValorTotal();
var
  nValorTotal : Double;
begin
  nValorTotal := 0;

  if    (DataModuleDB.SQLQueryConsultaItensOS.Active = True)
    and (DataModuleDB.SQLQueryConsultaItensOS.RecordCount > 0) then
  begin
    DataModuleDB.SQLQueryConsultaItensOS.First;
    while not DataModuleDB.SQLQueryConsultaItensOS.EOF do
    begin
      nValorTotal := nValorTotal + DataModuleDB.SQLQueryConsultaItensOS.FieldByName('nVALOR_TOTAL').AsFloat;
      DataModuleDB.SQLQueryConsultaItensOS.Next;
		end;
    DataModuleDB.SQLQueryConsultaItensOS.First;
	end;

  LabelValorTotalOS.Caption := FloatToStr(nValorTotal);
end;

procedure TFormOrdemServico.ConsultaOS(cCODIGO : String);
begin
  DataModuleDB.SQLQueryScript.Active := False;
  DataModuleDB.SQLQueryScript.SQL.Text := ' SELECT *';
  DataModuleDB.SQLQueryScript.SQL.Add(    '   FROM TB_OS');
  DataModuleDB.SQLQueryScript.SQL.Add(    '        INNER JOIN TB_CLIENTES ON TB_CLIENTES.cCPF_CL = TB_OS.cCPF_OS');
  DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE iCODIGO_OS = ' + cCODIGO);
  DataModuleDB.SQLQueryScript.Active := True;

  if DataModuleDB.SQLQueryScript.RecordCount < 1 then
  begin
    ShowMessage('Não foi possível carregar as informações da OS!');
    Exit;
	end;

  MaskEditCPFCliente.Text     := DataModuleDB.SQLQueryScript.FieldByName('cCPF_OS').AsString;
  EditCPFCliente.Text         := DataModuleDB.SQLQueryScript.FieldByName('cCPF_OS').AsString;
  EditNomeCliente.Text        := DataModuleDB.SQLQueryScript.FieldByName('cNOME_CL').AsString;
  EditEnderecoCliente.Text    := DataModuleDB.SQLQueryScript.FieldByName('cENDERECO_CL').AsString;
  EditNumeroEndCliente.Text   := DataModuleDB.SQLQueryScript.FieldByName('cNUMERO_CL').AsString;
  EditCidadeCliente.Text      := DataModuleDB.SQLQueryScript.FieldByName('cCIDADE_CL').AsString;
  EditUFCliente.Text          := DataModuleDB.SQLQueryScript.FieldByName('cUF_CL').AsString;
  EditNumeroOS.Text           := DataModuleDB.SQLQueryScript.FieldByName('iCODIGO_OS').AsString;
  MaskEditDataAberturaOS.Text := DataModuleDB.SQLQueryScript.FieldByName('dDATA_OS').AsString;
  MaskEditDataFinalizaOS.Text := DataModuleDB.SQLQueryScript.FieldByName('dDATA_FIM_OS').AsString;
  EditUsuarioAberturaOS.Text  := DataModuleDB.SQLQueryScript.FieldByName('cUSUARIO_OS').AsString;
  EditUsuarioFinalizaOS.Text  := DataModuleDB.SQLQueryScript.FieldByName('cUSUARIO_FIM_OS').AsString;
  MemoDescricaoOS.Text        := DataModuleDB.SQLQueryScript.FieldByName('cDESCRICAO_OS').AsString;
  EditFabricanteVeiculo.Text  := DataModuleDB.SQLQueryScript.FieldByName('cFABRICANTE_VE_OS').AsString;
  EditModeloVeiculo.Text      := DataModuleDB.SQLQueryScript.FieldByName('cMODELO_VE_OS').AsString;
  EditPlacaVeiculo.Text       := DataModuleDB.SQLQueryScript.FieldByName('cPLACA_VE_OS').AsString;
  BitBtnPesquisarOS.Enabled   := False;

  DataModuleDB.SQLQueryConsultaItensOS.Active                              := False;
  DataModuleDB.SQLQueryConsultaItensOS.ParamByName('iCODIGO_OS').AsInteger := StrToInt(cCODIGO);
  DataModuleDB.SQLQueryConsultaItensOS.Active                              := True;
end;

procedure TFormOrdemServico .MenuItemExcluirClick (Sender : TObject );
begin
  if    (DataModuleDB.SQLQueryConsultaItensOS.Active = True)
    and (DataModuleDB.SQLQueryConsultaItensOS.RecordCount > 0) then
  begin
    if MaskEditDataFinalizaOS.Text <> '' then
    begin
      ShowMessage('OS já finalizada, não pode ser alterada!');
      Exit;
		end;

    if MessageDlg('','Confirma a exclusão desse(a) Serviço/Peça?',mtConfirmation,mbYesNo,'') = mrNo then
    begin
      Exit;
		end;

    DataModuleDB.SQLQueryScript.Active := False;
    DataModuleDB.SQLQueryScript.SQL.Text := ' DELETE';
    DataModuleDB.SQLQueryScript.SQL.Add(    '   FROM TB_ITENS_OS');
    DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE iCODIGO_IOS = ' + DataModuleDB.SQLQueryConsultaItensOS.FieldByName('iCODIGO_IOS').AsString);
    DataModuleDB.SQLQueryScript.ExecSQL;
    DataModuleDB.SQLQueryConsultaItensOS.Close;
    DataModuleDB.SQLQueryConsultaItensOS.Open;
    CalculaValorTotal();
	end;
end;

procedure TFormOrdemServico.MaskEditCPFClienteExit(Sender: TObject);
begin
  if MaskEditCPFCliente.Text <> '' then
  begin
    DataModuleDB.SQLQueryClientes.Close;
    DataModuleDB.SQLQueryClientes.Filtered := False;
    DataModuleDB.SQLQueryClientes.Filter := 'cCPF_CL = ' + #39 + MaskEditCPFCliente.Text + #39;
    DataModuleDB.SQLQueryClientes.Filtered := True;
    DataModuleDB.SQLQueryClientes.Open;

    if    (DataModuleDB.SQLQueryClientes.RecordCount > 0)
      and (DataModuleDB.SQLQueryClientes.FieldByName('cCPF_CL').AsString = MaskEditCPFCliente.Text) then
    begin
      EditNomeCliente.Text      := DataModuleDB.SQLQueryClientes.FieldByName('cNOME_CL').AsString;
      EditEnderecoCliente.Text  := DataModuleDB.SQLQueryClientes.FieldByName('cENDERECO_CL').AsString;
      EditNumeroEndCliente.Text := DataModuleDB.SQLQueryClientes.FieldByName('cNUMERO_CL').AsString;
      EditCidadeCliente.Text    := DataModuleDB.SQLQueryClientes.FieldByName('cCIDADE_CL').AsString;
      EditUFCliente.Text        := DataModuleDB.SQLQueryClientes.FieldByName('cUF_CL').AsString;
      EditCPFCliente.Text       := DataModuleDB.SQLQueryClientes.FieldByName('cCPF_CL').AsString;
		end
    else
    begin
      ShowMessage('CPF não cadastrado!');
      EditNomeCliente.Text      := '';
      EditEnderecoCliente.Text  := '';
      EditNumeroEndCliente.Text := '';
      EditCidadeCliente.Text    := '';
      EditUFCliente.Text        := '';
      EditCPFCliente.Text       := '';
		end;
	end;
end;

procedure TFormOrdemServico.FormClose(Sender: TObject;
			var CloseAction: TCloseAction);
begin
  DataModuleDB.SQLQueryServicosPecas.Close;
  DataModuleDB.SQLQueryOS.Close;
  DataModuleDB.SQLQueryScript.Active := False;
  DataModuleDB.SQLQueryConsultaItensOS.Active := False;
  CloseAction := caFree;
  FormOrdemServico := Nil;
end;

procedure TFormOrdemServico .FormShow (Sender : TObject );
begin
  DataModuleDB.SQLQueryServicosPecas.Open;
  CalculaValorTotal();
end;

procedure TFormOrdemServico.BitBtnInsertOSClick(Sender: TObject);
begin
  HabilitaCampos(True,'1');
  cMetodo := 'I';
end;

procedure TFormOrdemServico .BitBtnPesquisarOSClick (Sender : TObject );
begin
  FormConsultaOrdemServico := TFormConsultaOrdemServico.Create(Application);
  FormConsultaOrdemServico.ShowModal;
end;

procedure TFormOrdemServico .BitBtnSaveOSClick (Sender : TObject );
begin
  if EditCPFCliente.Text = '' then
  begin
    ShowMessage('Selecione um cliente!');
    Exit;
	end;

  if cMetodo = 'I' then
  begin
    DataModuleDB.SQLQueryOS.Close;
    DataModuleDB.SQLQueryOS.Open;
    DataModuleDB.SQLQueryOS.Append;
    DataModuleDB.SQLQueryOS.FieldByName('cCPF_OS').Value           := EditCPFCliente.Text;
    DataModuleDB.SQLQueryOS.FieldByName('cDESCRICAO_OS').Value     := MemoDescricaoOS.Text;
    DataModuleDB.SQLQueryOS.FieldByName('cFABRICANTE_VE_OS').Value := EditFabricanteVeiculo.Text;
    DataModuleDB.SQLQueryOS.FieldByName('cMODELO_VE_OS').Value     := EditModeloVeiculo.Text;
    DataModuleDB.SQLQueryOS.FieldByName('cPLACA_VE_OS').Value      := EditPlacaVeiculo.Text;
    DataModuleDB.SQLQueryOS.FieldByName('dDATA_OS').Value          := Now;
    DataModuleDB.SQLQueryOS.FieldByName('cUSUARIO_OS').Value       := FormPrincipal.StatusBarPrincipal.Panels[1].Text;
    try
      DataModuleDB.SQLQueryOS.Post;
      DataModuleDB.SQLQueryOS.Close;
      DataModuleDB.SQLQueryOS.Open;
      DataModuleDB.SQLQueryOS.Last;
      EditNumeroOS.Text           := IntToStr(DataModuleDB.SQLQueryOS.FieldByName('iCODIGO_OS').AsInteger);
      MaskEditDataAberturaOS.Text := DataModuleDB.SQLQueryOS.FieldByName('dDATA_OS').AsString;
      EditUsuarioAberturaOS.Text  := DataModuleDB.SQLQueryOS.FieldByName('cUSUARIO_OS').AsString;
      HabilitaCampos(False,'0');
		except
      DataModuleDB.SQLQueryOS.Cancel;
		end;
	end;

  if cMetodo = 'U' then
  begin
    if EditCPFCliente.Text = '' then
    begin
      ShowMessage('Informe o Cliente!');
      Exit;
		end;

    DataModuleDB.SQLQueryScript.Active := False;
    DataModuleDB.SQLQueryScript.SQL.Text := ' UPDATE TB_OS';
    DataModuleDB.SQLQueryScript.SQL.Add(    '    SET cCPF_OS = ' + #39 + EditCPFCliente.Text + #39);
    DataModuleDB.SQLQueryScript.SQL.Add(    '      , cDESCRICAO_OS = ' + #39 + MemoDescricaoOS.Text + #39);
    DataModuleDB.SQLQueryScript.SQL.Add(    '      , cFABRICANTE_VE_OS = ' + #39 + EditFabricanteVeiculo.Text + #39);
    DataModuleDB.SQLQueryScript.SQL.Add(    '      , cMODELO_VE_OS = ' + #39 + EditModeloVeiculo.Text + #39);
    DataModuleDB.SQLQueryScript.SQL.Add(    '      , cPLACA_VE_OS = ' + #39 + EditPlacaVeiculo.Text + #39);
    DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE iCODIGO_OS = ' + EditNumeroOS.Text);
    DataModuleDB.SQLQueryScript.ExecSQL;
    HabilitaCampos(False,'0');
	end;

  if Assigned(FormConsultaOrdemServico) then
  begin
    FormConsultaOrdemServico.BitBtnConsultar.Click;
	end;
end;

procedure TFormOrdemServico .ButtonAddServicoPecaClick (Sender : TObject );
var
  cDesc : String;
begin
  cDesc := InputBox('Informe a descrição do Serviço/Peça','','');
  if cDesc <> '' then
  begin
    if Length(cDesc) > 200 then
    begin
      ShowMessage('Descrição não pode ser maior que 200 caracteres!');
      Exit;
		end;
		DataModuleDB.SQLQueryServicosPecas.Append;
    DataModuleDB.SQLQueryServicosPecas.FieldByName('cDESCRICAO_SP').Value := cDesc;
    DataModuleDB.SQLQueryServicosPecas.Post;
    DataModuleDB.SQLQueryServicosPecas.Close;
    DataModuleDB.SQLQueryServicosPecas.Open;
	end;
end;

procedure TFormOrdemServico.BitBtnCancelOSClick(Sender: TObject);
begin
  if cMetodo = 'I' then
  begin
    HabilitaCampos(False,'1');
	end
  else
  begin
    HabilitaCampos(False,'0');
	end;
end;

procedure TFormOrdemServico .BitBtnDeleteOSClick (Sender : TObject );
begin
  if EditNumeroOS.Text = '' then
  begin
    ShowMessage('Selecione uma OS para cancelar!');
    Exit;
	end;

  if MaskEditDataFinalizaOS.Text <> '' then
  begin
    ShowMessage('OS já finalizada, não pode ser cancelada!');
    Exit;
	end;

  if MessageDlg('','Confirma o cancelamento dessa OS?',mtConfirmation,mbYesNo,'') = mrNo then
  begin
    Exit;
	end;

  DataModuleDB.SQLQueryScript.Active := False;
  DataModuleDB.SQLQueryScript.SQL.Text := ' UPDATE TB_OS';
  DataModuleDB.SQLQueryScript.SQL.Add(    '    SET dDATA_CAN_OS = datetime('+#39+'now'+#39+','+#39+'localtime'#39+')');
  DataModuleDB.SQLQueryScript.SQL.Add(    '      , cUSUARIO_CAN_OS = ' + #39 + FormPrincipal.StatusBarPrincipal.Panels[1].Text + #39);
  DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE iCODIGO_OS = ' + EditNumeroOS.Text);
  DataModuleDB.SQLQueryScript.ExecSQL;
  DataModuleDB.SQLTransaction.Commit;
  HabilitaCampos(False,'1');
  if Assigned(FormConsultaOrdemServico) then
  begin
    FormConsultaOrdemServico.BitBtnConsultar.Click;
	end;
	ShowMessage('OS cancelada!');
end;

procedure TFormOrdemServico .BitBtnEditOSClick (Sender : TObject );
begin
  if EditNumeroOS.Text = '' then
  begin
    ShowMessage('Não tem OS para alteração!');
    Exit;
	end;

  if MaskEditDataFinalizaOS.Text <> '' then
  begin
    ShowMessage('OS já finalizada, não pode ser alterada!');
    Exit;
	end;

  cMetodo := 'U';
  HabilitaCampos(True,'0');
end;

procedure TFormOrdemServico .BitBtnImprimirOSClick (Sender : TObject );
  var
    html    : TStringList;
    caminho : String;
begin
  if EditNumeroOS.Text <> '' then
  begin
    caminho := ExtractFilePath(Application.ExeName) + 'lib\comprovantes\' + EditNumeroOS.Text + '.html';
    if FileExists(caminho) then
    begin
      DeleteFile(caminho);
		end;

    if DataModuleDB.SQLQueryCFGSistema.Active = False then
    begin
      DataModuleDB.SQLQueryCFGSistema.Active := True;
		end;

    DataModuleDB.SQLQueryComprovanteOS.Active := False;
    DataModuleDB.SQLQueryComprovanteOS.ParamByName('iCODIGO').AsInteger := StrToInt(EditNumeroOS.Text);
    DataModuleDB.SQLQueryComprovanteOS.Active := True;

    if DataModuleDB.SQLQueryComprovanteOS.FieldByName('dDATA_FIM_OS').AsString = '' then
    begin
      ShowMessage('OS precisa ser finalizada antes de imprimir!');
      Exit;
		end;

		html := TStringList.Create;
    html.Add('<!DOCTYPE html>');
    html.Add('<html>');
    html.Add('<head>');
    html.Add('<link href="../materialize/css/materialize.css" rel="stylesheet">');
    html.Add('<meta charset="utf-8">');
    html.Add('</head>');
    html.Add('<body>');
    html.Add('<div class="container">');
    html.Add('<div class="row">');
    html.Add('<div class="col m2">');
    html.Add('<img class="responsive-img" src="../../'+DataModuleDB.SQLQueryCFGSistema.FieldByName('cLOGO_CFG').AsString+'" alt="logo" style="width:128px;height:128px;">');
    html.Add('</div>');
    html.Add('<div class="col m10"><h3>'+DataModuleDB.SQLQueryCFGSistema.FieldByName('cNOME_FANTASIA_CFG').AsString+'</h3></div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">');
    html.Add('<h4>Ordem de Serviço - '+EditNumeroOS.Text+'</h4>');
    html.Add('</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12"><b>Dados do Prestador</b></div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m4">CNPJ: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cCNPJ_CFG').AsString+'</div>');
    html.Add('<div class="col m6">Razão Social :'+DataModuleDB.SQLQueryCFGSistema.FieldByName('cRAZAO_SOCIAL_CFG').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Endereço: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cENDERECO_CFG').AsString+', ' +DataModuleDB.SQLQueryCFGSistema.FieldByName('cNUMERO_CFG').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Cidade: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cCIDADE_CFG').AsString+' '+ 'UF: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cUF_CFG').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Contado: Tel: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cTELEFONE_CL').AsString+' Cel: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cCELULAR_CL').AsString+' E-mail: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cEMAIL_CL').AsString+' WebSite: '+DataModuleDB.SQLQueryCFGSistema.FieldByName('cSITE_CL').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12"><b>Dados do Cliente</b></div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m4">CPF: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cCPF_CL').AsString+'</div>');
    html.Add('<div class="col m6">Nome '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cNOME_CL').AsString+':</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Endereço '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cENDERECO_CL').AsString+':</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Cidade: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cCIDADE_CL').AsString+' UF: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cUF_CL').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Contato: Tel: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cTELEFONE_CL').AsString+' Cel: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cCELULAR_CL').AsString+' E-mail: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cEMAIL_CL').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12"><b>Dados da OS</b></div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m6">Data Inicio: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('dDATA_OS').AsString+'</div>');
    html.Add('<div class="col m6">Data Finaliza: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('dDATA_FIM_OS').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Descrição: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cDESCRICAO_OS').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12">Dados do veículo: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cFABRICANTE_VE_OS').AsString+' '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cMODELO_VE_OS').AsString+' Placa: '+DataModuleDB.SQLQueryComprovanteOS.FieldByName('cPLACA_VE_OS').AsString+'</div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m12"><b>Serviços Prestados</b></div>');
    html.Add('</div>');
    html.Add('<table>');
    html.Add('<thead>');
    html.Add('<tr>');
    html.Add('<th>Descrição</th>');
    html.Add('<th>Quantidade</th>');
    html.Add('<th>Valor Unitário</th>');
    html.Add('<th>Valor Total</th>');
    html.Add('</tr>');
    html.Add('</thead>');
    html.Add('<tbody>');
    if DataModuleDB.SQLQueryConsultaItensOS.RecordCount > 0 then
    begin
      DataModuleDB.SQLQueryConsultaItensOS.First;
      while not DataModuleDB.SQLQueryConsultaItensOS.EOF do
      begin
		    html.Add('<tr>');
        html.Add('<td>'+DataModuleDB.SQLQueryConsultaItensOS.FieldByName('cDESCRICAO_SP').AsString+'</td>');
        html.Add('<td>'+DataModuleDB.SQLQueryConsultaItensOS.FieldByName('iQUANTIDADE_IOS').AsString+'</td>');
        html.Add('<td>'+DataModuleDB.SQLQueryConsultaItensOS.FieldByName('nVALOR_UNI_IOS').AsString+'</td>');
        html.Add('<td>'+DataModuleDB.SQLQueryConsultaItensOS.FieldByName('nVALOR_TOTAL').AsString+'</td>');
        html.Add('</tr>');
        DataModuleDB.SQLQueryConsultaItensOS.Next;
      end;
    end;
    html.Add('</tbody>');
    html.Add('</table>');
    html.Add('<div class="row">');
    html.Add('<div class="col m4 offset-m8"><b>Valor Total: R$ '+LabelValorTotalOS.Caption+'</b></div>');
    html.Add('</div>');
    html.Add('<div class="row">');
    html.Add('<div class="col m2">');
    html.Add('<a  href="" onclick="window.print();">Imprimir</a>');
    html.Add('</div>');
    html.Add('</div>');
    html.Add('</div>');
    html.Add('<script type="text/javascript" src="../materialize/js/materialize.js"></script>');
    html.Add('</body>');
    html.Add('</html>');
    html.SaveToFile(caminho);
    html.Free;
    OpenURL(caminho);
    ShowMessage('Aguarde, OS será aberta no seu navegador padrão, para impressão!');
	end
  else
  begin
    ShowMessage('Não existe OS para imprimir!');
	end;
end;

procedure TFormOrdemServico .BitBtnIncluirServicoPecaIOSClick (Sender : TObject
		);
begin
  if EditNumeroOS.Text = '' then
  begin
    ShowMessage('Consulte ou Cadastre uma OS primeiro!');
    Exit;
	end;

  if MaskEditDataFinalizaOS.Text <> '' then
  begin
    ShowMessage('OS já finalizada, não pode ser alterada!');
    Exit;
	end;

	if DBLookupComboBoxServicoPecaIOS.KeyValue = null then
  begin
    ShowMessage('Selecione o Serviço/Peça!');
    Exit;
	end;

  if EditQuantidadeIOS.Text <> '' then
  begin
    try
      StrToInt(EditQuantidadeIOS.Text);
		except
		  ShowMessage('Informe apenas números inteiros na quantidade!');
      Exit;
		end;
	end
  else
  begin
    ShowMessage('Informe a quantidade!');
    Exit;
	end;

  if EditValorUnitarioIOS.Text <> '' then
  begin
    try
      StrToFloat(EditValorUnitarioIOS.Text);
    except
      ShowMessage('Informe apenas valores numéricos para o valor unitário!');
      Exit;
		end;
	end
  else
  begin
    ShowMessage('Informe o valor unitário!');
    Exit;
	end;

  DataModuleDB.SQLQueryItensOS.Close;
  DataModuleDB.SQLQueryItensOS.Open;
  DataModuleDB.SQLQueryItensOS.Append;
  DataModuleDB.SQLQueryItensOS.FieldByName('iCOD_OS_IOS').Value     := EditNumeroOS.Text;
  DataModuleDB.SQLQueryItensOS.FieldByName('iCOD_SP_IOS').Value     := DBLookupComboBoxServicoPecaIOS.KeyValue;
  DataModuleDB.SQLQueryItensOS.FieldByName('iQUANTIDADE_IOS').Value := StrToInt(EditQuantidadeIOS.Text);
  DataModuleDB.SQLQueryItensOS.FieldByName('nVALOR_UNI_IOS').Value  := StrToFloat(EditValorUnitarioIOS.Text);
  DataModuleDB.SQLQueryItensOS.FieldByName('cUSUARIO_IOS').Value    := FormPrincipal.StatusBarPrincipal.Panels[1].Text;
  DataModuleDB.SQLQueryItensOS.FieldByName('dDATA_IOS').Value       := Now;
  DataModuleDB.SQLQueryItensOS.Post;

  DataModuleDB.SQLQueryConsultaItensOS.Close;
  DataModuleDB.SQLQueryConsultaItensOS.ParamByName('iCODIGO_OS').AsInteger := StrToInt(EditNumeroOS.Text);
  DataModuleDB.SQLQueryConsultaItensOS.Open;
  CalculaValorTotal();
  DBLookupComboBoxServicoPecaIOS.KeyValue := null;
  EditQuantidadeIOS.Text := '';
  EditValorUnitarioIOS.Text := '';
end;

procedure TFormOrdemServico.BitBtnCadastrarClienteClick(Sender: TObject);
begin
  FormCliente := TFormCliente.Create(Application);
  FormCliente.ShowModal;
end;

end.

