unit u_consultaordemservico ;

{$mode objfpc}{$H+}

interface

uses
    Classes , SysUtils , db , Forms , Controls , Graphics , Dialogs , DBGrids ,
		MaskEdit , StdCtrls , ExtCtrls , Buttons , Menus ;

type

		{ TFormConsultaOrdemServico }

    TFormConsultaOrdemServico = class(TForm )
				BitBtnConsultar : TBitBtn ;
				DataSourceConsultaOS : TDataSource ;
				DBGridConsultaOS : TDBGrid ;
				EditNumeroOS : TEdit ;
				GroupBoxPeriodo : TGroupBox ;
				Label1 : TLabel ;
				Label2 : TLabel ;
				Label3 : TLabel ;
				Label4 : TLabel ;
				MaskEditDataIni : TMaskEdit ;
				MaskEditDataFinal : TMaskEdit ;
				MaskEditCPF : TMaskEdit ;
				MenuItemFinalizar : TMenuItem ;
				PopupMenuConsultaOS : TPopupMenu ;
				RadioGroupStatus : TRadioGroup ;
				procedure BitBtnConsultarClick (Sender : TObject );
				procedure DBGridConsultaOSDblClick (Sender : TObject );
				procedure FormClose (Sender : TObject ; var CloseAction : TCloseAction
						);
				procedure MenuItemFinalizarClick (Sender : TObject );
    private

    public

    end;

var
    FormConsultaOrdemServico : TFormConsultaOrdemServico ;

implementation
  uses
      U_principal, u_DataModuleDB, u_ordemservico;
{$R *.lfm}

{ TFormConsultaOrdemServico }

procedure TFormConsultaOrdemServico .BitBtnConsultarClick (Sender : TObject );
var
    cStatus   : String;
    cDataIni  : String;
    cDataFim  : String;
    cScript   : String;
begin
  case RadioGroupStatus.ItemIndex of
    0 : cStatus := ' AND dDATA_CAN_OS IS NULL AND dDATA_FIM_OS IS NULL';
    1 : cStatus := ' AND dDATA_FIM_OS IS NOT NULL';
    2 : cStatus := ' AND dDATA_CAN_OS IS NOT NULL';
    3 : cStatus := '';
  end;

  if MaskEditDataIni.Text <> '' then
  begin
    cDataIni := Copy(MaskEditDataIni.Text,5,4) + '-'
              + Copy(MaskEditDataIni.Text,3,2) + '-'
              + Copy(MaskEditDataIni.Text,1,2)
              + ' 00:00:00';

  end
  else
  begin
    cDataIni := '';
	end;

  if MaskEditDataFinal.Text <> '' then
  begin
	  cDataFim := Copy(MaskEditDataFinal.Text,5,4) + '-'
              + Copy(MaskEditDataFinal.Text,3,2) + '-'
              + Copy(MaskEditDataFinal.Text,1,2)
              + ' 23:59:59';
  end
  else
  begin
    cDataFim := '';
	end;

  cScript :=  ' SELECT iCODIGO_OS'
           +  '      , cCPF_OS'
           +  '      , cNOME_CL'
           +  '      , cDESCRICAO_OS'
           +  '      , dDATA_OS'
           +  '      , cUSUARIO_OS'
           +  '      , dDATA_FIM_OS'
           +  '      , dDATA_CAN_OS'
           +  '      , cUSUARIO_FIM_OS'
           +  '      , cUSUARIO_CAN_OS'
           +  '      , CASE WHEN dDATA_CAN_OS IS NOT NULL'
           +  '             THEN ' +#39+'Cancelada'+#39
           +  '             WHEN dDATA_FIM_OS IS NOT NULL'
           +  '             THEN ' +#39+'Finalizada'+#39
           +  '             ELSE ' +#39+'Pendente'+#39
           +  '         END cSTATUS'
           +  '   FROM TB_OS'
           +  '        INNER JOIN TB_CLIENTES ON TB_CLIENTES.cCPF_CL = TB_OS.cCPF_OS'
           +  '  WHERE 1=1';


  if cStatus <> '' then
  begin
    cScript := cScript + cStatus;
	end;

  if MaskEditCPF.Text <> '' then
  begin
    cScript := cScript + ' AND cCPF_OS = ' + #39 + MaskEditCPF.Text + #39;
  end;

  if cDataIni <> '' then
  begin
    cScript := cScript + ' AND DATETIME(dDATA_OS) >= '+#39+cDataIni+#39;
  end;

  if cDataFim <> '' then
  begin
    cScript := cScript + ' AND DATETIME(dDATA_OS) <= ' +#39+cDataFim+#39;
  end;

  if EditNumeroOS.Text <> '' then
  begin
    cScript := cScript + ' AND iCODIGO_OS = ' + EditNumeroOS.Text;
	end;

  cScript := cScript + ' ORDER BY iCODIGO_OS;';
	DataModuleDB.SQLQueryConsultaOS.Active   := False;
  DataModuleDB.SQLQueryConsultaOS.SQL.Text := cScript;
	DataModuleDB.SQLQueryConsultaOS.Active   := True;
end;

procedure TFormConsultaOrdemServico .DBGridConsultaOSDblClick (Sender : TObject
		);
begin
  if    (DataModuleDB.SQLQueryConsultaOS.Active = True)
    and (DataModuleDB.SQLQueryConsultaOS.RecordCount > 0) then
  begin
    if DataModuleDB.SQLQueryConsultaOS.FieldByName('dDATA_CAN_OS').AsString <> '' then
    begin
      ShowMessage('Ordem de serviço cancelada, não pode mais ser visualizada!');
      Exit;
		end;

    if Assigned(FormOrdemServico) then
    begin
      FormOrdemServico.ConsultaOS(DataModuleDB.SQLQueryConsultaOS.FieldByName('iCODIGO_OS').AsString);
      Close;
		end
    else
    begin
      FormOrdemServico := TFormOrdemServico.Create(Application);
      FormOrdemServico.ConsultaOS(DataModuleDB.SQLQueryConsultaOS.FieldByName('iCODIGO_OS').AsString);
      FormOrdemServico.ShowModal;
		end;
	end;
end;

procedure TFormConsultaOrdemServico .FormClose (Sender : TObject ;
		var CloseAction : TCloseAction );
begin
  DataModuleDB.SQLQueryConsultaOS.Active := False;
  DataModuleDB.SQLQueryScript.Active     := False;
  CloseAction := caFree;
  FormConsultaOrdemServico := Nil;
end;

procedure TFormConsultaOrdemServico .MenuItemFinalizarClick (Sender : TObject );
begin
  if    (DataModuleDB.SQLQueryConsultaOS.Active = True)
    and (DataModuleDB.SQLQueryConsultaOS.RecordCount > 0) then
  begin
    if DataModuleDB.SQLQueryConsultaOS.FieldByName('dDATA_FIM_OS').AsString <> '' then
    begin
      ShowMessage('Ordem de Serviço já finalizada!');
      Exit;
		end;

    if DataModuleDB.SQLQueryConsultaOS.FieldByName('dDATA_CAN_OS').AsString <> '' then
    begin
      ShowMessage('Ordem de Serviço está cancelada!');
      Exit;
		end;

    if MessageDlg('Finalização de Ordem de Serviço!','Confirma a finalização desta Ordem Serviço?',mtConfirmation,mbYesNo,'') = mrNo then
    begin
      Exit;
		end;

    DataModuleDB.SQLQueryConsultaItensOS.Active := False;
    DataModuleDB.SQLQueryConsultaItensOS.ParamByName('iCODIGO_OS').AsFloat := DataModuleDB.SQLQueryConsultaOS.FieldByName('iCODIGO_OS').AsFloat;
    DataModuleDB.SQLQueryConsultaItensOS.Active := True;

    if DataModuleDB.SQLQueryConsultaItensOS.RecordCount < 1 then
    begin
      ShowMessage('Ordem Serviço sem Itens/Serviços, não pode ser finalizada!');
      Exit;
		end;

    DataModuleDB.SQLQueryConsultaItensOS.Active := False;

    DataModuleDB.SQLQueryScript.Active := False;
    DataModuleDB.SQLQueryScript.SQL.Text := ' UPDATE TB_OS';
    DataModuleDB.SQLQueryScript.SQL.Add(    '    SET dDATA_FIM_OS = datetime('+#39+'now'+#39+','+#39+'localtime'#39+')');
    DataModuleDB.SQLQueryScript.SQL.Add(    '      , cUSUARIO_FIM_OS = ' + #39 + FormPrincipal.StatusBarPrincipal.Panels[1].Text + #39);
    DataModuleDB.SQLQueryScript.SQL.Add(    '  WHERE iCODIGO_OS = ' + DataModuleDB.SQLQueryConsultaOS.FieldByName('iCODIGO_OS').AsString);
    DataModuleDB.SQLQueryScript.ExecSQL;
    DataModuleDB.SQLTransaction.Commit;

    BitBtnConsultar.Click;
    ShowMessage('Ordem de Serviço Finalizada!');
	end;
end;

end.
