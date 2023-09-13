unit fOpcaoLista;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts;

type
  TFrameOpcaoLista = class(TFrame)
    LoBaseOpc: TLayout;
    RFundoMensagemOpc: TRectangle;
    RBackgroundTopoOpc: TRectangle;
    LblTituloMensagemOpc: TLabel;
    BtnFecharOpc: TRectangle;
    LblFecharOpc: TLabel;
    LoLeftOpc: TLayout;
    ImgConfirmacao: TImage;
    ImgInformacao: TImage;
    ImgSucesso: TImage;
    LoRodapeOpc: TLayout;
    Layout4: TLayout;
    BtnEditar: TRectangle;
    LblConfirmar: TLabel;
    BtnPagar: TRectangle;
    LblCancelar: TLabel;
    ShadowEffectOpc: TShadowEffect;
    LoCorpoOpc: TLayout;
    LblValor: TLabel;
    LblParcela: TLabel;
    Layout5: TLayout;
    LblDescricao: TLabel;
    LblCodigo: TLabel;
    RFundoBloqueioOpc: TRectangle;
    procedure BtnFecharOpcClick(Sender: TObject);
    procedure MostraOpcoes(Codigo, Descricao, Valor, Parcela: String; MostraMsg: Boolean);
    procedure BtnPagarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}


procedure TFrameOpcaoLista.BtnEditarClick(Sender: TObject);
begin
    //if BtnEditar.Tag = 0 then

    ShowMessage('OK');
end;

procedure TFrameOpcaoLista.BtnFecharOpcClick(Sender: TObject);
begin
    //ShowMessage('OK');

    MostraOpcoes('', '', '', '', False);
end;

procedure TFrameOpcaoLista.BtnPagarClick(Sender: TObject);
begin
    ShowMessage('OK');
end;

procedure TFrameOpcaoLista.MostraOpcoes(Codigo, Descricao, Valor, Parcela: String; MostraMsg: Boolean);
begin
    visible := MostraMsg;
    if not MostraMsg then exit;
    LblValor.Text := Valor;
    LblParcela.Text := Parcela;
    LblDescricao.Text := Descricao;
    LblCodigo.Text := Codigo;
    //LblTituloMensagem.Text := Titulo;
    //PainelMensagemPadrao;
    //EsconderImagens;

    //OK
    {
    if (TipoJanela = xMsgTipoSUCESSO) or (TipoJanela = xMsgTipoINFORMATIVA) or (TipoJanela = xMsgTipoNOME) then
    begin
        LblConfirmar.Text := 'OK';
        if TipoJanela = xMsgTipoSUCESSO then ImgSucesso.Visible := True;
        if TipoJanela = xMsgTipoINFORMATIVA then    ImgInformacao.Visible := True;
        if TipoJanela = xMsgTipoNOME then
        begin
            LblTextoMensagem.Visible := False;
            LoPainelEdit.Visible      := True;
        end;
        BtnCancelar.Visible := False;
        BtnConfirmar.Align := TAlignLayout.Client;
    end; }

    //CONFIRMAR/ CANCELAR
    //if TipoJanela = xMsgTipoCONFIRMAÇÃO then  ImgConfirmacao.Visible := True;
    {if TipoJanela = xMsgTipoNOME then
    begin
        LblTituloMensagem.Visible := False;
        LoPainelEdit.Visible      := True;
    end;   }


end;

end.
