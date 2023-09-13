unit uPrincipal;

interface

uses
  System.SysUtils, DateUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FMX.ListBox, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, Data.DB,
  FireDAC.Comp.Client, uLoading, FMX.Edit, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, System.IOUtils;

type
  TFrmPrincipal = class(TForm)
    FDConexao: TFDConnection;
    LoBase: TLayout;
    LoTopo: TLayout;
    Rectangle7: TRectangle;
    Layout7: TLayout;
    Label1: TLabel;
    Layout13: TLayout;
    Layout1: TLayout;
    Layout14: TLayout;
    Layout15: TLayout;
    Label8: TLabel;
    LblSaldo: TLabel;
    Layout16: TLayout;
    Layout17: TLayout;
    LblEntrada: TLabel;
    Label13: TLabel;
    Layout18: TLayout;
    LblSaida: TLabel;
    Label11: TLabel;
    LoRodape: TLayout;
    Layout9: TLayout;
    Layout11: TLayout;
    BtnAdicionar: TRectangle;
    LoCorpo: TLayout;
    Layout5: TLayout;
    LbFaturas: TListBox;
    Layout2: TLayout;
    Rectangle9: TRectangle;
    Layout3: TLayout;
    BtnMesAnterior: TRectangle;
    Layout4: TLayout;
    Layout19: TLayout;
    LblMesAtual: TLabel;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle6: TRectangle;
    Layout8: TLayout;
    Layout10: TLayout;
    Layout12: TLayout;
    Label2: TLabel;
    Rectangle8: TRectangle;
    BtnVoltar: TRectangle;
    RoundRect1: TRoundRect;
    LoNenhumRegistro: TLayout;
    Label3: TLabel;
    Layout20: TLayout;
    Rectangle1: TRectangle;
    StyleBook1: TStyleBook;
    procedure AdicionarProduto(ListBox: TListBox;
                                         IdProduto: Integer;
                                         Descricao,
                                         TipoLancamento,
                                         Status,
                                         Categoria,
                                         Data,
                                         Valor: String;
                                         ParcelaAtual, ParcelaTotal: Integer);
    procedure FormResize(Sender: TObject);
    procedure LbFaturasItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure BtnMesProximoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListarProdutos;
    procedure TerminateThread(Sender: TObject);
    procedure BtnMesAnteriorClick(Sender: TObject);
    procedure LblMesAtualClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);


    private

    { Private declarations }
    public
    { Public declarations }

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses fListaLancamento, VariaveisGlobais, Funcoes, uCadastroLancamento;

{$R *.fmx}

procedure TFrmPrincipal.BtnAdicionarClick(Sender: TObject);
begin
    //ListarProdutos;
    //ShowMessage('TEST');
    //BtnMesAnterior.Fill.Bitmap := BtnAdicionar.Fill.Bitmap;//'HamburgerMenu.png'

    FrmCadastroLancamento := TFrmCadastroLancamento.Create(nil);
    FrmCadastroLancamento.Tag := 1;
    FrmCadastroLancamento.Show;
end;

procedure TFrmPrincipal.BtnMesAnteriorClick(Sender: TObject);
begin
    LblMesAtual.Text := AtualizaDataSelecionada(False);
end;

procedure TFrmPrincipal.BtnMesProximoClick(Sender: TObject);
begin
    LblMesAtual.Text := AtualizaDataSelecionada(True);
end;

procedure TFrmPrincipal.BtnVoltarClick(Sender: TObject);
begin
    Close;
end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
    //FrmPrincipal.StyleBook := StyleBook1;
end;

procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
    //FrmPrincipal.StyleBook := StyleBook2;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
    with FDConexao do
    begin
        Params.Values['DriverID'] := 'SQLite';
        {$IFDEF ANDROID}
            Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'Controle.sqlite3');
        {$ENDIF}
        {$IFDEF MSWINDOWS}
            Params.Values['Database'] := 'E:\Delphi\Projetos\ContaWise\Database\Controle.sqlite3';
        {$ENDIF}


        SaldoD   := 0; EntradaD := 0;
        Saidad   := 0;
        CodigoUsuarioConectado := 1;
        LoNenhumRegistro.Visible := false;
        // Extrair o m�s da data
        xNumeroMes := MonthOf(Now);
        xNumeroAno := YearOf(Now);
        LblMesAtual.Text := AtualizaTextoMes + ' / '+xNumeroAno.ToString;

        FDQConsulta := TFDQuery.Create(nil);
        FDQConsulta.Connection := FDConexao;
        FDQInsert := TFDQuery.Create(nil);
        FDQInsert.Connection := FDConexao;


      try
        Connected := true;
      except on e:exception do
        raise Exception.create('Erro de conex�o com o banco de dados ' + e.Message);
      end;
    end;
end;

procedure TFrmPrincipal.FormResize(Sender: TObject);
begin
    LbFaturas.Columns := Trunc(FrmPrincipal.Width/ 300);
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    ListarProdutos;
end;

procedure TFrmPrincipal.LbFaturasItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    ShowMessage(Item.Tag.ToString);
end;

procedure TFrmPrincipal.LblMesAtualClick(Sender: TObject);
begin
    xNumeroMes := MonthOf(Now);
    xNumeroAno := YearOf(Now);
    LblMesAtual.Text := AtualizaTextoMes + ' / '+xNumeroAno.ToString;
end;

{
    ImgPago: TImage;
    LblStatus: TLabel;
    LblParcela: TLayout;
    LblDescricao: TLabel;
    LblData: TLabel;
    LblCategoria: TLabel;
    RecBarColor: TRectangle;
    LblValor: TLabel;
}
procedure TFrmPrincipal.AdicionarProduto(ListBox: TListBox;
                                         IdProduto: Integer;
                                         Descricao,
                                         TipoLancamento,
                                         Status,
                                         Categoria,
                                         Data,
                                         Valor: String;
                                         ParcelaAtual, ParcelaTotal: Integer);
var
  Item: TListBoxItem;
  Frame: TFrameLista;
  Parcela: String;
begin
    if (ParcelaAtual <> 0) and (ParcelaTotal <> 0) then
       Parcela := ParcelaAtual.ToString + ' / ' + ParcelaTotal.ToString
    else
       Parcela := '';

    //item vazio na listbox...
    Item := TListBoxItem.Create(nil);
    Item.Text := '';
    Item.Height := 55;
    Item.Margins.Left := 10;
    Item.Margins.Right := 10;
    Item.Margins.Bottom := 10;
    Item.Tag := IdProduto;
    Item.Selectable := false;

    //criar o frame...
    Frame := TFrameLista.Create(Item);
    Frame.Parent := Item;
    Frame.Align := TAlignLayout.Client;
    Frame.LblDescricao.Text := Descricao;



    Frame.LblParcela.Text := Parcela;
    Frame.LblStatus.Text := Status;


    Frame.ImgPago.Visible := false;
    Frame.ImgReceita.Visible := false;
    Frame.ImgPendente.Visible := false;
    Frame.ImgDespesa.Visible := false;

    if Status = 'DESPESA' then
           Frame.ImgDespesa.Visible := True;
    if Status = 'PENDENTE' then
           Frame.ImgPendente.Visible := true;
    if Status = 'RECEITA' then
           Frame.ImgReceita.Visible := true;
    if Status = 'PAGO' then
           Frame.ImgPago.Visible := true;


    if (Status = 'PENDENTE') or (Status = 'DESPESA') then
    begin
        Frame.LblStatus.FontColor := xCorRED;
        Frame.LblValor.FontColor := xCorRED;
        Frame.LblParcela.FontColor := xCorRED;
        Frame.RecBarColor.Fill.Color := xCorRed;
    end
    else
    begin
        Frame.LblStatus.FontColor := xCorGREEN;
        Frame.LblValor.FontColor := xCorGREEN;
        Frame.LblParcela.FontColor := xCorGREEN;
        Frame.RecBarColor.Fill.Color := xCorGREEN;
    end;

    //Frame.LblValor.Text := Valor;
    if TipoLancamento = 'RECEITA' then
    begin
        SaldoD     := SaldoD + StrToCurr(Valor);
        EntradaD   := EntradaD + StrToCurr(Valor);
       //ValorTotal := EntradaD - SaidaD;
    end
    else if TipoLancamento = 'DESPESA' then
    begin
        if Parcela <> '' then
        begin
            if Status = 'PENDENTE' then
            begin
                ValorMes   := StrToCurr(Valor) / ParcelaTotal;
                Valor      := CurrToStr(ValorMes);
            end
            else
            begin
                SaldoD     := SaldoD - StrToCurr(Valor);
                SaidaD     := SaidaD + StrToCurr(Valor);
                ValorMes   := StrToCurr(Valor) / ParcelaTotal;
                Valor      := CurrToStr(ValorMes);
            end;
        end
        else
        begin
            SaldoD     := SaldoD - StrToCurr(Valor);
            SaidaD     := SaidaD + StrToCurr(Valor);
        end;

        //ValorTotal := EntradaD - SaidaD;
    end;
    ValorTotal := EntradaD - SaidaD;
    Frame.LblValor.Text := FormatCurr('R$ #,##0.00', StrToCurr(Valor));
    LblSaldo.Text       := FormatCurr('R$ #,##0.00', ValorTotal);
    LblEntrada.Text     := FormatCurr('R$ #,##0.00', EntradaD);
    LblSaida.Text       := FormatCurr('R$ #,##0.00', SaidaD);


    Frame.LblData.Text := Data;
    //Frame.BtnMenu.OnClick := NomeDaProcedure;
    ListBox.AddObject(Item);
end;

procedure TFrmPrincipal.ListarProdutos;
var
  Th: TThread;
begin
    TLoading.Show(FrmPrincipal, 'Buscando informa��es...');
    LbFaturas.BeginUpdate;
    SaldoD   := 0;
    EntradaD := 0;
    Saidad   := 0;
    LbFaturas.Items.Clear;
    LoNenhumRegistro.Visible := false;
    //btnRefresh.Enable := false;

    Th := TThread.CreateAnonymousThread(procedure
    begin
        //select no banco....
        sleep(1000);

        TThread.Synchronize(TThread.CurrentThread, procedure
        begin
            AdicionarProduto(LbFaturas, 1, 'COMPRA DA TELEVIS�O', 'DESPESA'  ,'PAGO'     , 'COMPRA DE CASA', '18/08/2023', '1115,99'  ,  1, 3);//
            AdicionarProduto(LbFaturas, 2, 'VIAGEM'             , 'DESPESA'  ,'PENDENTE' , 'LAZER'         , '19/08/2023', '199,00'    ,  2, 3);//
            AdicionarProduto(LbFaturas, 3, 'LANCHE DE DOMINGO'  , 'DESPESA'  ,'DESPESA'  , 'LANCHE'        , '20/08/2023', '79,99'     ,  0, 0);//
            AdicionarProduto(LbFaturas, 4, 'PAGAMENTO DO M�S'   , 'RECEITA'  ,'RECEITA'  , 'PAGAMENTO'     , '28/08/2023', '3000,00'  ,  0, 0);
            AdicionarProduto(LbFaturas, 1, 'COMPRA DA TELEVIS�O', 'DESPESA'  ,'PAGO'     , 'COMPRA DE CASA', '18/08/2023', '1115,99'  ,  1, 3);//
            AdicionarProduto(LbFaturas, 2, 'VIAGEM'             , 'DESPESA'  ,'PENDENTE' , 'LAZER'         , '19/08/2023', '199,00'    ,  2, 3);//
            AdicionarProduto(LbFaturas, 3, 'LANCHE DE DOMINGO'  , 'DESPESA'  ,'DESPESA'  , 'LANCHE'        , '20/08/2023', '79,99'     ,  0, 0);//
            AdicionarProduto(LbFaturas, 4, 'PAGAMENTO DO M�S'   , 'RECEITA'  ,'RECEITA'  , 'PAGAMENTO'     , '28/08/2023', '3000,00'  ,  0, 0);
            AdicionarProduto(LbFaturas, 1, 'COMPRA DA TELEVIS�O', 'DESPESA'  ,'PAGO'     , 'COMPRA DE CASA', '18/08/2023', '1115,99'  ,  1, 3);//
            AdicionarProduto(LbFaturas, 2, 'VIAGEM'             , 'DESPESA'  ,'PENDENTE' , 'LAZER'         , '19/08/2023', '199,00'    ,  2, 3);//
            AdicionarProduto(LbFaturas, 3, 'LANCHE DE DOMINGO'  , 'DESPESA'  ,'DESPESA'  , 'LANCHE'        , '20/08/2023', '79,99'     ,  0, 0);//
            AdicionarProduto(LbFaturas, 4, 'PAGAMENTO DO M�S'   , 'RECEITA'  ,'RECEITA'  , 'PAGAMENTO'     , '28/08/2023', '3000,00'  ,  0, 0);
            AdicionarProduto(LbFaturas, 1, 'COMPRA DA TELEVIS�O', 'DESPESA'  ,'PAGO'     , 'COMPRA DE CASA', '18/08/2023', '1115,99'  ,  1, 3);//
            AdicionarProduto(LbFaturas, 2, 'VIAGEM'             , 'DESPESA'  ,'PENDENTE' , 'LAZER'         , '19/08/2023', '199,00'    ,  2, 3);//
            AdicionarProduto(LbFaturas, 3, 'LANCHE DE DOMINGO'  , 'DESPESA'  ,'DESPESA'  , 'LANCHE'        , '20/08/2023', '79,99'     ,  0, 0);//
            AdicionarProduto(LbFaturas, 4, 'PAGAMENTO DO M�S'   , 'RECEITA'  ,'RECEITA'  , 'PAGAMENTO'     , '28/08/2023', '3000,00'  ,  0, 0);
            AdicionarProduto(LbFaturas, 1, 'COMPRA DA TELEVIS�O', 'DESPESA'  ,'PAGO'     , 'COMPRA DE CASA', '18/08/2023', '1115,99'  ,  1, 3);//
            AdicionarProduto(LbFaturas, 2, 'VIAGEM'             , 'DESPESA'  ,'PENDENTE' , 'LAZER'         , '19/08/2023', '199,00'    ,  2, 3);//
            AdicionarProduto(LbFaturas, 3, 'LANCHE DE DOMINGO'  , 'DESPESA'  ,'DESPESA'  , 'LANCHE'        , '20/08/2023', '79,99'     ,  0, 0);//
            AdicionarProduto(LbFaturas, 4, 'PAGAMENTO DO M�S'   , 'RECEITA'  ,'RECEITA'  , 'PAGAMENTO'     , '28/08/2023', '3000,00'  ,  0, 0);

            if LbFaturas.Items.Count = 0 then
               LoNenhumRegistro.Visible := true;
        end);
    end);
    //th.FreeOnTerminate := true; caso seja false, ele n�o � matado automaticamente da memoria.
    th.OnTerminate := TerminateThread;
    th.Start;
end;

procedure TFrmPrincipal.TerminateThread(Sender: TObject);
begin
    if Assigned(TThread(Sender).FatalException) then
       ShowMessage(Exception(TThread(Sender).FatalException).Message);
    TLoading.Hide;
    LbFaturas.EndUpdate;
end;


end.
