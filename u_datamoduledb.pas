unit u_DataModuleDB;

{$mode objfpc}{$H+}

interface

uses
      Classes, SysUtils, sqlite3conn, sqldb, db, sqlscript, Dialogs;

type

			{ TDataModuleDB }

      TDataModuleDB = class(TDataModule)
						SQLite3ConnectionDB: TSQLite3Connection;
						SQLQueryCFGSistemacCELULAR_CL : TStringField ;
						SQLQueryCFGSistemacEMAIL_CL : TStringField ;
						SQLQueryCFGSistemacSITE_CL : TStringField ;
						SQLQueryCFGSistemacTELEFONE_CL : TStringField ;
						SQLQueryComprovanteOS : TSQLQuery ;
						SQLQueryComprovanteOScBAIRRO_CL : TStringField ;
						SQLQueryComprovanteOScCELULAR_CL : TStringField ;
						SQLQueryComprovanteOScCEP_CL : TStringField ;
						SQLQueryComprovanteOScCIDADE_CL : TStringField ;
						SQLQueryComprovanteOScCOMPLEMENTO_CL : TStringField ;
						SQLQueryComprovanteOScCPF_CL : TStringField ;
						SQLQueryComprovanteOScDESCRICAO_OS : TStringField ;
						SQLQueryComprovanteOScEMAIL_CL : TStringField ;
						SQLQueryComprovanteOScENDERECO_CL : TStringField ;
						SQLQueryComprovanteOScFABRICANTE_VE_OS : TStringField ;
						SQLQueryComprovanteOScMODELO_VE_OS : TStringField ;
						SQLQueryComprovanteOScNOME_CL : TStringField ;
						SQLQueryComprovanteOScNUMERO_CL : TStringField ;
						SQLQueryComprovanteOScPLACA_VE_OS : TStringField ;
						SQLQueryComprovanteOScTELEFONE_CL : TStringField ;
						SQLQueryComprovanteOScUF_CL : TStringField ;
						SQLQueryComprovanteOSdDATA_FIM_OS : TDateTimeField ;
						SQLQueryComprovanteOSdDATA_OS : TDateTimeField ;
						SQLQueryComprovanteOSiCODIGO_OS : TLongintField ;
						SQLQueryConsultaOS : TSQLQuery ;
						SQLQueryConsultaItensOS : TSQLQuery ;
						SQLQueryConsultaItensOScDESCRICAO_SP : TStringField ;
						SQLQueryConsultaItensOScUSUARIO_IOS : TStringField ;
						SQLQueryConsultaItensOSdDATA_IOS : TDateTimeField ;
						SQLQueryConsultaItensOSiCODIGO_IOS : TLongintField ;
						SQLQueryConsultaItensOSiQUANTIDADE_IOS : TLongintField ;
						SQLQueryConsultaItensOSnVALOR_TOTAL : TFloatField ;
						SQLQueryConsultaItensOSnVALOR_UNI_IOS : TFloatField ;
						SQLQueryConsultaOScCPF_OS : TStringField ;
						SQLQueryConsultaOScDESCRICAO_OS : TStringField ;
						SQLQueryConsultaOScNOME_CL : TStringField ;
						SQLQueryConsultaOScSTATUS : TStringField ;
						SQLQueryConsultaOScUSUARIO_CAN_OS : TStringField ;
						SQLQueryConsultaOScUSUARIO_FIM_OS : TStringField ;
						SQLQueryConsultaOScUSUARIO_OS : TStringField ;
						SQLQueryConsultaOSdDATA_CAN_OS : TDateTimeField ;
						SQLQueryConsultaOSdDATA_FIM_OS : TDateTimeField ;
						SQLQueryConsultaOSdDATA_OS : TDateTimeField ;
						SQLQueryConsultaOSiCODIGO_OS : TLongintField ;
						SQLQueryItensOS : TSQLQuery ;
						SQLQueryItensOScUSUARIO_IOS : TStringField ;
						SQLQueryItensOSdDATA_IOS : TDateTimeField ;
						SQLQueryItensOSiCODIGO_IOS : TLongintField ;
						SQLQueryItensOSiCOD_OS_IOS : TLongintField ;
						SQLQueryItensOSiCOD_SP_IOS : TLongintField ;
						SQLQueryItensOSiQUANTIDADE_IOS : TLongintField ;
						SQLQueryItensOSnVALOR_UNI_IOS : TFloatField ;
						SQLQueryServicosPecas : TSQLQuery ;
						SQLQueryOS : TSQLQuery ;
						SQLQueryClientes: TSQLQuery;
						SQLQueryClientescBAIRRO_CL: TStringField;
						SQLQueryClientescCELULAR_CL: TStringField;
						SQLQueryClientescCEP_CL: TStringField;
						SQLQueryClientescCIDADE_CL: TStringField;
						SQLQueryClientescCOMPLEMENTO_CL: TStringField;
						SQLQueryClientescCPF_CL: TStringField;
						SQLQueryClientescDATA_CL: TDateTimeField;
						SQLQueryClientescEMAIL_CL: TStringField;
						SQLQueryClientescENDERECO_CL: TStringField;
						SQLQueryClientescNOME_CL: TStringField;
						SQLQueryClientescNUMERO_CL: TStringField;
						SQLQueryClientescTELEFONE_CL: TStringField;
						SQLQueryClientescUF_CL: TStringField;
						SQLQueryClientescUSUARIO_CL: TStringField;
						SQLQueryOScCPF_OS : TStringField ;
						SQLQueryOScDESCRICAO_OS : TStringField ;
						SQLQueryOScFABRICANTE_VE_OS : TStringField ;
						SQLQueryOScMODELO_VE_OS : TStringField ;
						SQLQueryOScPLACA_VE_OS : TStringField ;
						SQLQueryOScUSUARIO_CAN_OS : TStringField ;
						SQLQueryOScUSUARIO_FIM_OS : TStringField ;
						SQLQueryOScUSUARIO_OS : TStringField ;
						SQLQueryOSdDATA_CAN_OS : TDateTimeField ;
						SQLQueryOSdDATA_FIM_OS : TDateTimeField ;
						SQLQueryOSdDATA_OS : TDateTimeField ;
						SQLQueryOSiCODIGO_OS : TLongintField ;
						SQLQueryServicosPecascDESCRICAO_SP : TStringField ;
						SQLQueryServicosPecasiCODIGO_SP : TLongintField ;
						SQLQueryUsuarios: TSQLQuery;
						SQLQueryCFGSistema: TSQLQuery;
						SQLQueryCFGSistemacBAIRRO_CFG: TStringField;
						SQLQueryCFGSistemacCEP_CFG: TStringField;
						SQLQueryCFGSistemacCIDADE_CFG: TStringField;
						SQLQueryCFGSistemacCNPJ_CFG: TStringField;
						SQLQueryCFGSistemacCOMPLEMENTO_CFG: TStringField;
						SQLQueryCFGSistemacENDERECO_CFG: TStringField;
						SQLQueryCFGSistemacIE_CFG: TStringField;
						SQLQueryCFGSistemacLOGO_CFG: TStringField;
						SQLQueryCFGSistemacNOME_FANTASIA_CFG: TStringField;
						SQLQueryCFGSistemacNUMERO_CFG: TStringField;
						SQLQueryCFGSistemacRAZAO_SOCIAL_CFG: TStringField;
						SQLQueryCFGSistemacUF_CFG: TStringField;
						SQLQueryScript: TSQLQuery;
						SQLQueryUsuarioscLOGIN_US: TStringField;
						SQLQueryUsuarioscNOME_US: TStringField;
						SQLQueryUsuarioscSENHA_US: TStringField;
						SQLQueryUsuarioscTIPO_US: TStringField;
						SQLScript: TSQLScript;
						SQLTransaction: TSQLTransaction;
						procedure DataModuleCreate(Sender: TObject);
						procedure SQLQueryCFGSistemaAfterDelete(DataSet: TDataSet);
						procedure SQLQueryCFGSistemaAfterPost(DataSet: TDataSet);
						procedure SQLQueryClientesAfterDelete(DataSet: TDataSet);
						procedure SQLQueryClientesAfterPost(DataSet: TDataSet);
						procedure SQLQueryItensOSAfterDelete (DataSet : TDataSet );
						procedure SQLQueryItensOSAfterPost (DataSet : TDataSet );
						procedure SQLQueryOSAfterDelete (DataSet : TDataSet );
						procedure SQLQueryOSAfterPost (DataSet : TDataSet );
						procedure SQLQueryServicosPecasAfterDelete (DataSet : TDataSet );
						procedure SQLQueryServicosPecasAfterPost (DataSet : TDataSet );
						procedure SQLQueryUsuariosAfterDelete(DataSet: TDataSet);
						procedure SQLQueryUsuariosAfterPost(DataSet: TDataSet);
      private

      public

      end;

var
      DataModuleDB: TDataModuleDB;

implementation

{$R *.lfm}

{ TDataModuleDB }

procedure TDataModuleDB.DataModuleCreate(Sender: TObject);
var cCaminhoDB : String;
begin
  cCaminhoDB := 'banco.db';
  if not FileExists(cCaminhoDB) then
  begin
    SQLite3ConnectionDB.DatabaseName := cCaminhoDB;
    SQLite3ConnectionDB.Connected := True;
    try
      SQLScript.ExecuteScript;
      SQLTransaction.Commit;
		except;
      SQLTransaction.Rollback;
		end;
	end
  else
  begin
    SQLite3ConnectionDB.DatabaseName := cCaminhoDB;
	end;
end;

procedure TDataModuleDB.SQLQueryCFGSistemaAfterDelete(DataSet: TDataSet);
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryCFGSistema.GetBookmark;
  	SQLQueryCFGSistema.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryCFGSistema.GotoBookmark(posicao);
  	end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao excluir registro!');
  end;
end;

procedure TDataModuleDB.SQLQueryCFGSistemaAfterPost(DataSet: TDataSet);
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryCFGSistema.GetBookmark;
  	SQLQueryCFGSistema.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryCFGSistema.GotoBookmark(posicao);
  	end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao salvar registro!');
  end;
end;

procedure TDataModuleDB.SQLQueryClientesAfterDelete(DataSet: TDataSet);
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryClientes.GetBookmark;
  	SQLQueryClientes.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryClientes.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao excluir registro!');
  end;
end;

procedure TDataModuleDB.SQLQueryClientesAfterPost(DataSet: TDataSet);
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryClientes.GetBookmark;
  	SQLQueryClientes.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryClientes.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao salvar registro!');
  end;
end;

procedure TDataModuleDB .SQLQueryItensOSAfterDelete (DataSet : TDataSet );
var
  posicao : TBookMark;
begin
  try
     posicao:= SQLQueryItensOS.GetBookmark;
   	SQLQueryItensOS.ApplyUpdates;
     if SQLTransaction.Active then
     begin
       SQLTransaction.CommitRetaining;
       SQLQueryItensOS.GotoBookmark(posicao);
     end;
   except
     SQLTransaction.Rollback;
     ShowMessage('Erro ao excluir registro!');
   end;
end;

procedure TDataModuleDB .SQLQueryItensOSAfterPost (DataSet : TDataSet );
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryItensOS.GetBookmark;
   	SQLQueryItensOS.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryItensOS.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao salvar registro!');
  end;
end;

procedure TDataModuleDB .SQLQueryOSAfterDelete (DataSet : TDataSet );
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryOS.GetBookmark;
  	SQLQueryOS.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryOS.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao excluir registro!');
  end;
end;

procedure TDataModuleDB .SQLQueryOSAfterPost (DataSet : TDataSet );
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryOS.GetBookmark;
  	SQLQueryOS.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryOS.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao salvar registro!');
  end;
end;

procedure TDataModuleDB .SQLQueryServicosPecasAfterDelete (DataSet : TDataSet );
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryServicosPecas.GetBookmark;
  	SQLQueryServicosPecas.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryServicosPecas.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao excluir registro!');
  end;
end;

procedure TDataModuleDB .SQLQueryServicosPecasAfterPost (DataSet : TDataSet );
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryServicosPecas.GetBookmark;
  	SQLQueryServicosPecas.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryServicosPecas.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao salvar registro!');
  end;
end;

procedure TDataModuleDB.SQLQueryUsuariosAfterDelete(DataSet: TDataSet);
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryUsuarios.GetBookmark;
  	SQLQueryUsuarios.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryUsuarios.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao excluir registro!');
  end;
end;

procedure TDataModuleDB.SQLQueryUsuariosAfterPost(DataSet: TDataSet);
var
  posicao : TBookMark;
begin
  try
    posicao:= SQLQueryUsuarios.GetBookmark;
  	SQLQueryUsuarios.ApplyUpdates;
    if SQLTransaction.Active then
    begin
      SQLTransaction.CommitRetaining;
      SQLQueryUsuarios.GotoBookmark(posicao);
    end;
  except
    SQLTransaction.Rollback;
    ShowMessage('Erro ao salvar registro!');
  end;
end;

end.

