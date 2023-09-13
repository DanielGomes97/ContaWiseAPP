unit VariaveisGlobais;

interface

uses
   System.UITypes, FireDAC.Comp.Client;


var
  //Variaveis Usada no M�s....
  xNumeroMes, xNumeroAno: Word;


  SaldoD, ValorTotal, ValorMes, EntradaD, SaidaD: Currency; //painel principal;


  CodigoUsuarioConectado : Integer = 0;
  NomeUsuarioConectado   : String  = '';
  UsuarioConectado       : Boolean = False;

  //
  FDQConsulta: TFDQuery;
  FDQInsert: TFDQuery;


  EdicaoLiberada: Boolean = true;



  //******* MENSAGEM RETORNO *******
  //xMsgSucesso: String = 'Lan�amento foi dicionado com sucesso!';


  //******* TIPO MENSAGEM *******
  xMsgTipoSUCESSO    :  String = 'SUCESSO';
  xMsgTipoCONFIRMA��O:  String = 'CONFIRMA��O';
  xMsgTipoINFORMATIVA:  String = 'INFORMATIVA';
  xMsgTipoNOME       :  String = 'NOME';



  //******* CORES DA JANELA *******
  xCorRED:   TAlphaColor = $FFDB5050;
  xCorBLUE:  TAlphaColor = $FF5072DB;
  xCorGREEN: TAlphaColor = $FF5EDB50;
  //FF5EDB50 //GREEN
  //FFD6DB50 //YELLOW
  //FF030303 //BLACK
  //FFFEFEFE //WHITE
  //FF8B8B8B //GRAY

  ModeDARK: Boolean = False;

  //Cores Mode DARK
  BackgroundDarkD: TAlphaColor = $FF00000; //
  BackgroundWhiteD: TAlphaColor = $FF00000; //
  TextWhiteD: TAlphaColor = $FF00000; //
  TextDarkD: TAlphaColor = $FF00000; //
  ColorWhiteD: TAlphaColor = $FF00000; //
  ColorDarkD: TAlphaColor = $FF00000; //
  ColorGrayD: TAlphaColor = $FF00000; //




  //Cores Mode WHITE























implementation
end.
