unit Funcoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FMX.ListBox, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, Data.DB,
  FireDAC.Comp.Client, FireDac.Stan.Param,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;


    function AtualizaDataSelecionada(Proximo: Boolean): String;
    function AtualizaTextoMes: String;
    function IncrementaNovoCodigo(Tbl: TDataSet; Codigo: String): Integer;
    function VerificaExisteDescricao(Tabela, CampoPesquisa, Parametro: String): Boolean;
    function VerificaExisteCodigo(Tabela, CampoPesquisa: String; Parametro: Integer): Boolean;
    function RecuperaDescricao(Tabela, Descricao, Codigo: String;  Parametro: Integer = 0): String;
    procedure AlimentaCboVG(LVCombo: TListView; Tabela, Codigo, Descricao: String);
    function ApagaRegistro(Tabela, Codigo: String; Parametro: Integer): Boolean;

implementation

uses fListaLancamento, VariaveisGlobais;

function AtualizaDataSelecionada(Proximo: Boolean): String;
begin
    if Proximo then
    begin
        if xNumeroMes = 12 then
        begin
            xNumeroMes := 1;
            Inc(xNumeroAno);
        end
        else
           Inc(xNumeroMes);
    end
    else
    begin
        if xNumeroMes = 1 then
        begin
            xNumeroMes := 12;
            Dec(xNumeroAno);
        end
        else
           Dec(xNumeroMes);
    end;
    Result := AtualizaTextoMes+ ' / '+xNumeroAno.ToString;
end;

function AtualizaTextoMes: String;
begin
    if xNumeroMes = 1 then       Result := 'Janeiro'
    else if xNumeroMes = 2 then  Result := 'Fevereiro'
    else if xNumeroMes = 3 then  Result := 'Março'
    else if xNumeroMes = 4 then  Result := 'Abril'
    else if xNumeroMes = 5 then  Result := 'Maio'
    else if xNumeroMes = 6 then  Result := 'Junho'
    else if xNumeroMes = 7 then  Result := 'Julho'
    else if xNumeroMes = 8 then  Result := 'Agosto'
    else if xNumeroMes = 9 then  Result := 'Setembro'
    else if xNumeroMes = 10 then Result := 'Outubro'
    else if xNumeroMes = 11 then Result := 'Novembro'
    else if xNumeroMes = 12 then Result := 'Dezembro'
    else Result := '';
end;



function IncrementaNovoCodigo(Tbl: TDataSet; Codigo: String): Integer;
var
  NovoCodigo: Integer;
begin
    Tbl.DisableControls;
    Tbl.Last;
    NovoCodigo := Tbl.FieldByName(Codigo).AsInteger + 1;
    Tbl.EnableControls;
    if not (Tbl.State in [dsInsert]) then
       Tbl.Insert;

    Tbl.FieldByName(Codigo).AsInteger := NovoCodigo;
    result := NovoCodigo;
end;


function VerificaExisteDescricao(Tabela, CampoPesquisa, Parametro: String): Boolean;
begin
    with FDQConsulta do
    begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT '+CampoPesquisa+' FROM '+Tabela+' WHERE '+CampoPesquisa+' =:pPesquisa');
        Params.ParamByName('pPesquisa').AsString := Parametro;
        Open();

        if RecordCount > 0 then
            Result := True
        else
            Result := False;
    end;
end;

function VerificaExisteCodigo(Tabela, CampoPesquisa: String; Parametro: Integer): Boolean;
begin
    with FDQConsulta do
    begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT '+CampoPesquisa+' FROM '+Tabela+' WHERE '+CampoPesquisa+' =:pCodigo');
        Params.ParamByName('pCodigo').AsInteger := Parametro;
        Open();

        if RecordCount > 0 then
            Result := True
        else
            Result := False;
    end;
end;

function RecuperaDescricao(Tabela, Descricao, Codigo: String;  Parametro: Integer = 0): String;
begin
    Result := '';
    //if Parametro < 0 then Parametro := 0;
    with FDQConsulta do
    begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT '+ Descricao +' FROM '+ Tabela +' WHERE '+ Codigo +' =:pCodigo');
        Params.ParamByName('pCodigo').AsInteger := Parametro;
        Open();

        if RecordCount > 0 then
            Result := FieldByName(Descricao).AsString
        else
            Result := '';
    end;
end;

procedure AlimentaCboVG(LVCombo: TListView; Tabela, Codigo, Descricao: String);
var
  xCount: Integer;
begin
    with FDQConsulta do
    begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ' + Codigo + ', ' + Descricao + ' FROM ' + Tabela);
        Open();

        LVCombo.Visible := true;
        LVCombo.BeginUpdate;
        LVCombo.Items.Clear;
        xCount := 1;

        LVCombo.Items.Add.Text := 'Adicionar uma nova categoria';
        LVCombo.Items.Item[0].Tag := 0;
        First;
        while not EOF do
        begin
            LVCombo.Items.Add.Text := FieldByName(Descricao).AsString;
            LVCombo.Items.Item[xCount].Tag := FieldByName(Codigo).AsInteger;
            Inc(xCount);
            Next;
        end;
        LVCombo.EndUpdate;
    end;
end;

function ApagaRegistro(Tabela, Codigo: String; Parametro: Integer): Boolean;
begin
    //Result := False;
    with FDQConsulta do
    begin
        try
        begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM ' +Tabela+ ' WHERE '+Codigo+' =:CodParametro');
            Params.ParamByName('CodParametro').AsInteger := Parametro;
            ExecSQL;
            Result := False;
            //FrameMensagem1.MostraMensagem(xMsgTipoSUCESSO,'Registros excluído com sucesso.', true)
        end
        except
            on E: Exception do
            begin
                Result := False;
                //FrameMensagem1.MostraMensagem(xMsgTipoINFORMATIVA,'Erro ao excluir registro: ' + E.Message, true)
            end;
        end;
    end;
end;


end.
