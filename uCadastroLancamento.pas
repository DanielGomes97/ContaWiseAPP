unit uCadastroLancamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FMX.TabControl, FMX.DateTimeCtrls, Data.Bind.Controls, Fmx.Bind.Navigator,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope, Data.DB,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FireDac.Stan.Param, fMensagem, FMX.ListBox;

type
  TFrmCadastroLancamento = class(TForm)
    LoBase: TLayout;
    RBackground: TRectangle;
    LoTopo: TLayout;
    RBackgroundTopo: TRectangle;
    LoTopoRight: TLayout;
    LoTopoLeft: TLayout;
    LoTopoCenter: TLayout;
    LblTituloLancamento: TLabel;
    LoCorpo: TLayout;
    Layout2: TLayout;
    LoRodape: TLayout;
    Rectangle3: TRectangle;
    BtnVoltar: TRectangle;
    Rectangle8: TRectangle;
    Layout1: TLayout;
    BtnSalvar: TRectangle;
    RbReceita: TRadioButton;
    RbDespesa: TRadioButton;
    CkbRepetir: TCheckBox;
    Layout4: TLayout;
    Layout5: TLayout;
    Label2: TLabel;
    EditDescricao: TEdit;
    Layout3: TLayout;
    Label5: TLabel;
    EditValor: TEdit;
    Layout8: TLayout;
    Label6: TLabel;
    CkbParcelado: TCheckBox;
    LoPainelParcelado: TLayout;
    Layout13: TLayout;
    Layout14: TLayout;
    LoCheckboxParcelado: TLayout;
    Layout11: TLayout;
    Layout17: TLayout;
    Image1: TImage;
    Layout18: TLayout;
    BindNavigator1: TBindNavigator;
    BtnExcluir: TRectangle;
    Image4: TImage;
    Label3: TLabel;
    Layout7: TLayout;
    Label4: TLabel;
    Layout6: TLayout;
    Label7: TLabel;
    BtnCancelar: TRectangle;
    Image5: TImage;
    Label11: TLabel;
    LoEditsParcela: TLayout;
    Layout20: TLayout;
    Label12: TLabel;
    EditParcelaAtual: TEdit;
    Layout21: TLayout;
    Label13: TLabel;
    EditTotalParcela: TEdit;
    Layout22: TLayout;
    Label14: TLabel;
    EditDInicio: TDateEdit;
    LblMensagemParcelasCadastradas: TLabel;
    BtnNovo: TRectangle;
    Layout10: TLayout;
    LblCodigo: TLabel;
    Layout12: TLayout;
    Label8: TLabel;
    LblValor: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    FrameMensagem1: TFrameMensagem;
    RecCombo: TRectangle;
    LVCombo: TListView;
    Layout9: TLayout;
    Rectangle5: TRectangle;
    Layout15: TLayout;
    Layout19: TLayout;
    BtnFecharLV: TRectangle;
    Layout23: TLayout;
    Label9: TLabel;
    Edit1: TEdit;
    StyleBook1: TStyleBook;
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BindNavigator1Click(Sender: TObject; Button: TNavigateButton);
    procedure CkbParceladoChange(Sender: TObject);
    procedure RbReceitaChange(Sender: TObject);
    procedure RbDespesaChange(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure LVComboItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure CkbRepetirClick(Sender: TObject);
    procedure RbDespesaClick(Sender: TObject);
    procedure RbReceitaClick(Sender: TObject);
    procedure FrameMensagem1BtnConfirmarClick(Sender: TObject);
    procedure EditValorChangeTracking(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure BtnFecharLVClick(Sender: TObject);
    procedure LVComboItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    procedure VerificaRadioButtonSelecionado;
    procedure AtualizaInformacoesCombo;


    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroLancamento: TFrmCadastroLancamento;

implementation

{$R *.fmx}

uses uPrincipal, DataModulo, Funcoes, VariaveisGlobais, uCadastroCategoria;


procedure TFrmCadastroLancamento.AtualizaInformacoesCombo;
begin
    CkbRepetir.Visible := false;

    if DM.TblLancamento.FieldByName('TipoLancamento').AsString = 'D' then RbDespesa.IsChecked := true
    else if DM.TblLancamento.FieldByName('TipoLancamento').AsString = 'R' then
    begin
       RbReceita.IsChecked := true;
       CkbRepetir.Visible := true;
    end;
    if DM.TblLancamento.FieldByName('Parcelado').AsString = 'S' then CkbParcelado.IsChecked := true
    else  CkbParcelado.IsChecked := False;//
    if DM.TblLancamento.FieldByName('Repetir').AsString = 'S' then   CkbRepetir.IsChecked := true
    else  CkbRepetir.IsChecked := false;

    Edit1.Text := RecuperaDescricao('CATEGORIA', 'Descricao', 'CODCATEGORIA', DM.TblLancamento.FieldByName('CodCategoria').AsInteger);
    VerificaRadioButtonSelecionado;
end;

procedure TFrmCadastroLancamento.VerificaRadioButtonSelecionado;
begin
    LoPainelParcelado.Visible := False;
    LblMensagemParcelasCadastradas.Visible := False;
    LoEditsParcela.Visible := False;
    LoCheckboxParcelado.Visible := False;
    CkbParcelado.Enabled   := True;
    CkbParcelado.IsChecked := False;
    LblMensagemParcelasCadastradas.Text := 'As parcelas deste lan�amento n�o podem ser alteradas, caso queira modificar algo nas parcelas, dever� realizar um novo registro e excluir esse lancamento atual.';

    if not(RbReceita.IsChecked) AND not(RbDespesa.IsChecked) then
    begin
       RbReceita.IsChecked := true;
       CkbRepetir.Visible := true;
    end;

    CkbRepetir.Visible := True;

    if RbDespesa.IsChecked then
    begin
        CkbRepetir.Visible := False;
        CkbRepetir.IsChecked := False;
        LoPainelParcelado.Visible := True;
        LoCheckboxParcelado.Visible := True;

        if VerificaExisteDados('LANCAMENTO', 'CodLancamento', LblCodigo.Text) then
        begin
            //LoPainelParcelado.Visible := true;
            LoCheckboxParcelado.Visible := False;
            LblMensagemParcelasCadastradas.Visible := true;
            CkbParcelado.IsChecked   := False;
            if DM.TblLancamento.FieldByName('Parcelado').AsString = 'S' then
            begin
                //LoPainelParcelado.Visible := True;
                LoCheckboxParcelado.Visible := True;
                CkbParcelado.Enabled   := False;
                CkbParcelado.IsChecked   := True;
                //LblMensagemParcelasCadastradas.Visible := True;
            end
            else
            begin
                LblMensagemParcelasCadastradas.Text := 'Esse lancamento j� foi cadastrado sem parcelas antes, caso queira adicionar parcelas, por favor, exclua esse registro e fa�a um novo cadastro incluindo as parcelas.';
            end;
        end;
    end;
end;


procedure TFrmCadastroLancamento.BindNavigator1Click(Sender: TObject;
  Button: TNavigateButton);
begin
    AtualizaInformacoesCombo;
end;

procedure TFrmCadastroLancamento.BtnCancelarClick(Sender: TObject);
begin
    if (DM.TblLancamento.State in [dsInsert, dsEdit]) then
    begin
        DM.TblLancamento.Cancel;
        BtnNovo.Enabled := true;
        BtnExcluir.Enabled := true;
        ShowMessage('Cancelado com sucesso');
    end;
end;

procedure TFrmCadastroLancamento.BtnExcluirClick(Sender: TObject);
begin
    if (not(DM.TblLancamento.State in [dsInsert])) and (LblCodigo.Text <> '') then
    begin
        DM.TblLancamento.Delete;
        ShowMessage('Deletado com sucesso');
    end;
end;

procedure TFrmCadastroLancamento.BtnFecharLVClick(Sender: TObject);
begin
    RecCombo.Visible := false;
end;

procedure TFrmCadastroLancamento.BtnNovoClick(Sender: TObject);
begin
    LblCodigo.Text := IncrementaNovoCodigo(DM.TblLancamento, 'CodLancamento').ToString;
    DM.TblLancamento.FieldByName('DataCadastro').AsDateTime := Now;
    BtnNovo.Enabled := false;
    BtnExcluir.Enabled := false;
    EditTotalParcela.Text := '';
    EditParcelaAtual.Text := '';
    AtualizaInformacoesCombo;
end;

procedure TFrmCadastroLancamento.BtnSalvarClick(Sender: TObject);
var
  Contador, ParcelaAtual: Integer;
  DataDaParcela: TDateTime;
begin
    if (DM.TblLancamento.State in [dsInsert, dsEdit]) then
    begin
        DM.TblLancamento.FieldByName('CodUsuario').AsInteger := CodigoUsuarioConectado;
        DM.TblLancamento.FieldByName('CodCategoria').AsInteger := 1;

        if RbReceita.IsChecked then
        begin
            DM.TblLancamento.FieldByName('TipoLancamento').AsString := 'R';
        end
        else if RbDespesa.IsChecked then
        begin
            DM.TblLancamento.FieldByName('TipoLancamento').AsString := 'D';
            DM.TblLancamento.FieldByName('Repetir').AsString := 'N';
        end;

        if CkbRepetir.IsChecked then
           DM.TblLancamento.FieldByName('Repetir').AsString := 'S'
        else
           DM.TblLancamento.FieldByName('Repetir').AsString := 'N';

        if CkbParcelado.IsChecked then
           DM.TblLancamento.FieldByName('Parcelado').AsString := 'S'
        else
           DM.TblLancamento.FieldByName('Parcelado').AsString := 'N';
    end;


    if (DM.TblLancamento.State in [dsInsert]) then
    begin
        //DM.TblLancamento.FieldByName('DataCadastro').AsDateTime := Now;
        if CkbParcelado.IsChecked then
        begin
            //verifica
            if (EditParcelaAtual.Text <> '') and (EditTotalParcela.Text  <> '') and (EditDescricao.Text  <> '') then
            begin
                ParcelaAtual := StrToInt(EditParcelaAtual.Text);
                DataDaParcela := StrToDateTime(EditDInicio.Text);
                for Contador := EditParcelaAtual.Text.ToInteger  to EditTotalParcela.Text.ToInteger do
                begin
                    with DM.TblParcela do
                    begin
                        FieldByName('CodParcela').AsInteger := IncrementaNovoCodigo(DM.TblParcela, 'CodParcela');
                        FieldByName('CodLancamento').AsInteger := DM.TblLancamento.FieldByName('CodLancamento').AsInteger;//StrToInt(LblCodigo.Text);
                        FieldByName('CodUsuario').AsInteger := CodigoUsuarioConectado;
                        FieldByName('DataInicio').AsDateTime := DataDaParcela;
                        FieldByName('ParcelaAtual').AsInteger := ParcelaAtual;
                        FieldByName('ParcelaTotal').AsInteger := StrToInt(EditTotalParcela.Text);
                        FieldByName('Status').AsString := 'PENDENTE';
                        Post;
                    end;
                    DataDaParcela := IncMonth(DataDaParcela);
                    Inc(ParcelaAtual);
                end;
            end;
        end;

        DM.TblLancamento.Post;
        BtnNovo.Enabled := true;
        BtnExcluir.Enabled := true;

        ShowMessage('Registro adicionado com sucesso!');
    end;
    if (DM.TblLancamento.State in [dsEdit]) then
    begin
        EdicaoLiberada := true;

        if (DM.TblLancamento.FieldByName('Parcelado').OldValue = 'S') and (DM.TblLancamento.FieldByName('Parcelado').NewValue = 'N') then
        begin
            //confirmar e deleta parcelas no banco...
            ShowMessage('O VALOR ANTERIOR ERA PARCELADO E AGORA NAO �...');
            FrameMensagem1.BtnConfirmar.Tag := 1;
            FrameMensagem1.MostraMensagem(xMsgTipoCONFIRMA��O,
                        'Voc� est� preste a apagar todas parcelas cadastradas nesse cadastro atual, voc� deseja realmente apagar essas parcelas? .', true);

            Application.ProcessMessages;
        end;


        if EdicaoLiberada then
        begin
            DM.TblLancamento.Post;
            BtnNovo.Enabled := true;
            BtnExcluir.Enabled := true;

            ShowMessage('Registro modificado com sucesso!');
        end
        else
            DM.TblLancamento.Cancel;
    end;

end;

procedure TFrmCadastroLancamento.BtnVoltarClick(Sender: TObject);
begin
    if (DM.TblLancamento.State in [dsInsert, dsEdit]) then
       DM.TblLancamento.Cancel;
    Close;
end;

procedure TFrmCadastroLancamento.CkbParceladoChange(Sender: TObject);
begin
    if not(DM.TblLancamento.State in [dsInsert]) then
       DM.TblLancamento.Edit;
    if CkbParcelado.IsChecked then
    begin
        if DM.TblLancamento.State in [dsInsert] then
        begin
            LoPainelParcelado.Visible := True;
            LblMensagemParcelasCadastradas.Visible := False;
            LoEditsParcela.Visible := True;
            LoCheckboxParcelado.Visible := True;
            CkbParcelado.Enabled   := True;
        end;
    end
    else
    begin
        LoPainelParcelado.Visible := True;
        LoEditsParcela.Visible := False;
        LoCheckboxParcelado.Visible := True;
    end;
end;

procedure TFrmCadastroLancamento.CkbRepetirClick(Sender: TObject);
begin
    if not(DM.TblLancamento.State in [dsInsert]) then
       DM.TblLancamento.Edit;
end;


procedure TFrmCadastroLancamento.Edit1Click(Sender: TObject);
begin
    LVCombo.Tag := 1;
    RecCombo.Visible := true;
    AlimentaCboVG(LVCombo, 'CATEGORIA', 'CodCategoria', 'Descricao');
end;

procedure TFrmCadastroLancamento.EditValorChangeTracking(Sender: TObject);
var
  Valor: Currency;
begin
    if TryStrToCurr(EditValor.Text, Valor) then
       LblValor.Text := 'Valor: R$ ' + FormatFloat('#,##0.00', Valor)
    else
       LblValor.Text := '';
end;

procedure TFrmCadastroLancamento.FormCreate(Sender: TObject);
begin
    DM.TblLancamento.Open();
    DM.TblParcela.Open();
    AtualizaInformacoesCombo;
    EditValor.MaxLength := 10;
    AlimentaCboVG(LVCombo, 'CATEGORIA', 'CodCategoria', 'Descricao');
end;

procedure TFrmCadastroLancamento.FrameMensagem1BtnConfirmarClick(
  Sender: TObject);
begin
    //caso deixe de ser parcelado e o torne receita.
    if FrameMensagem1.BtnConfirmar.Tag = 1 then
    begin
        if ApagaRegistro('PARCELADO', 'CODLANCAMENTO', LblCodigo.Text.ToInteger) then
            FrameMensagem1.MostraMensagem(xMsgTipoSUCESSO,'Registros exclu�do com sucesso.', true)
        else
            FrameMensagem1.MostraMensagem(xMsgTipoINFORMATIVA,'Erro ao excluir registro', true);

        {
        with FDQConsulta do
        begin
            try
            begin
                Close;
                SQL.Clear;
                SQL.Add('DELETE FROM PARCELADO WHERE CODLANCAMENTO =:CodLancamento');
                Params.ParamByName('CodLancamento').AsInteger := LblCodigo.Text.ToInteger;
                ExecSQL;

                FrameMensagem1.MostraMensagem(xMsgTipoSUCESSO,'Registros exclu�do com sucesso.', true)
            end
            except
                on E: Exception do
                begin
                    FrameMensagem1.MostraMensagem(xMsgTipoINFORMATIVA,'Erro ao excluir registro: ' + E.Message, true)

                end;
            end;
        end;  }

        FrameMensagem1.BtnConfirmar.Tag := 0;
    end
    else if FrameMensagem1.BtnConfirmar.Tag = 2 then//
    begin
        FrameMensagem1.BtnConfirmar.Tag := 0;
    end
    else
        FrameMensagem1.BtnConfirmarClick(Sender);
end;

procedure TFrmCadastroLancamento.LVComboItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    ShowMessage('Descricao: ' + AItem.Text +#13+#13+
                'C�digo   : ' + LVCombo.Items[LVCombo.ItemIndex].Tag.ToString);

    LVCombo.Visible := False;
end;

procedure TFrmCadastroLancamento.LVComboItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
  CodigonaTAG: Integer;
begin
    if LVCombo.Items.Item[ItemIndex].Tag = 0 then
    begin
        FrmCadastroCategoria := TFrmCadastroCategoria.Create(nil);
        FrmCadastroCategoria.Show;
        exit;
    end
    else
       CodigonaTAG :=  LVCombo.Items.Item[ItemIndex].Tag;

    if NOT(DM.TblLancamento.State in [dsInsert]) then
       DM.TblLancamento.Edit;

    if DM.TblLancamento.State in [dsInsert, dsEdit] then
    begin
        case LVCombo.Tag of
           1:
           begin
               DM.TblLancamento.FieldByName('codCategoria').AsInteger := CodigonaTAG;
               Edit1.Text := RecuperaDescricao('CATEGORIA', 'Descricao', 'CODCATEGORIA', CodigonaTAG);
           end;

        end;
    end;

    RecCombo.Visible := false;
end;

procedure TFrmCadastroLancamento.RbDespesaChange(Sender: TObject);
begin
   // AtualizaInformacoesCombo;
   // if not(DM.TblLancamento.State in [dsInsert, dsEdit]) then
   //    DM.TblLancamento.Edit;
    VerificaRadioButtonSelecionado;
end;

procedure TFrmCadastroLancamento.RbDespesaClick(Sender: TObject);
begin
    if not(DM.TblLancamento.State in [dsInsert]) then
       DM.TblLancamento.Edit;
end;

procedure TFrmCadastroLancamento.RbReceitaChange(Sender: TObject);
begin
    //if not(DM.TblLancamento.State in [dsInsert]) then
    //   DM.TblLancamento.Edit;
    VerificaRadioButtonSelecionado;
end;

procedure TFrmCadastroLancamento.RbReceitaClick(Sender: TObject);
begin
    if not(DM.TblLancamento.State in [dsInsert]) then
       DM.TblLancamento.Edit;
end;

end.
