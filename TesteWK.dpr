program TesteWK;

uses
  Vcl.Forms,
  Controller.Connection in 'Connection\Controller.Connection.pas',
  Model.Pedido in 'Model\Model.Pedido.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Model.Cliente in 'Model\Model.Cliente.pas',
  View.Pedido in 'View.Pedido.pas' {FrmPedido},
  Connection.DataModule in 'Connection\Connection.DataModule.pas' {DmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TFrmPedido, FrmPedido);
  Application.CreateForm(TDmConexao, DmConexao);
  Application.Run;
end.
