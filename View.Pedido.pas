unit View.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Controller.Connection, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, Vcl.StdCtrls, Vcl.Mask, Vcl.Samples.Spin, Model.Produto,
  FireDAC.Phys.MySQLDef, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Model.Cliente, Model.Pedido, Connection.DataModule;


type
  TFrmPedido = class(TForm)
    MtbPedido: TFDMemTable;
    DsPedido: TDataSource;
    DbgPedido: TDBGrid;
    MtbPedidoCodItem: TIntegerField;
    MtbPedidoCodProduto: TIntegerField;
    MtbPedidoDescricao: TStringField;
    MtbPedidoValorUnitario: TCurrencyField;
    MtbPedidoValorTotal: TCurrencyField;
    EdtProduto: TEdit;
    BtnGravar: TButton;
    SedQuantidade: TSpinEdit;
    EdtValorUnitario: TEdit;
    EdtDesc: TEdit;
    EdtValorTotal: TEdit;
    MtbPedidoQuantidade: TIntegerField;
    BtnCliente: TButton;
    EdtCliente: TEdit;
    EdtNomeCliente: TEdit;
    LblValorTotal: TLabel;
    BtnGravarPedido: TButton;
    BtnEditar: TButton;
    EdtEditarPedido: TEdit;
    BtnDeletarPedido: TButton;
    procedure FormCreate(Sender: TObject);
    procedure EdtValorUnitarioExit(Sender: TObject);
    procedure EdtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure BtnGravarClick(Sender: TObject);
    procedure DbgPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CalcularPrecoTotalItem(Sender: TObject);
    procedure EdtProdutoExit(Sender: TObject);
    procedure BtnClienteClick(Sender: TObject);
    procedure BtnGravarPedidoClick(Sender: TObject);
    procedure EdtClienteExit(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnDeletarPedidoClick(Sender: TObject);
  private
    { Private declarations }
    //FConexao: TConexao;
    FCliente : TCliente;
    FPedido : TPedido;

    procedure LimparCampos();
    procedure PreencherProduto();
    procedure TotalizarPedido();
    procedure LimparTela();
  public
    { Public declarations }
  end;

var
  FrmPedido: TFrmPedido;

implementation

uses
  Vcl.Dialogs;

{$R *.dfm}

procedure TFrmPedido.BtnClienteClick(Sender: TObject);
begin
  if Self.EdtCliente.Text = '' then
  begin
    raise Exception.Create('Código do Cliente precisa ser preenchido!');
  end;

  Self.FCliente := TCliente.Create(StrToInt(Self.EdtCliente.Text));
  if FCliente.Codigo > 0 then
  begin
    Self.EdtNomeCliente.Text := FCliente.Nome;

    Self.BtnEditar.Visible := False;
    Self.BtnEditar.Enabled := False;
    Self.BtnDeletarPedido.Visible := False;
    Self.BtnDeletarPedido.Enabled := False;
    Self.EdtEditarPedido.Visible := False;
    Self.EdtEditarPedido.Enabled := False;
  end
  else
  begin
    raise Exception.Create('Cliente não encontrado!');
  end;
end;

procedure TFrmPedido.BtnDeletarPedidoClick(Sender: TObject);
var
  Pedido: TPedido;
begin
  if Self.EdtEditarPedido.Text = '' then
  begin
    raise Exception.Create('Código do Pedido precisa ser preenchido!');
  end;

  Pedido := TPedido.Create(StrToInt(Self.EdtEditarPedido.Text));
  Pedido.Deletar();
  FreeAndNil(Pedido);
end;

procedure TFrmPedido.BtnEditarClick(Sender: TObject);
var
  Item : TItemPedido;
begin
  if Self.EdtEditarPedido.Text = '' then
  begin
    raise Exception.Create('Código do Pedido precisa ser preenchido!');
  end;

  Self.MtbPedido.Close();
  Self.MtbPedido.Open();
  FPedido := TPedido.Create(StrToInt(Self.EdtEditarPedido.Text));

  if FPedido.NumPedido > 0 then
  begin
    Self.EdtCliente.Text := FPedido.CodCliente.ToString();
    Self.BtnCliente.Click();

    for Item in FPedido.Itens do
    begin
      Self.EdtProduto.Text := Item.CodProduto.ToString;
      Self.PreencherProduto();

      Self.SedQuantidade.Value := Item.Quantidade;
      Self.EdtValorUnitario.Text := FormatFloat('###0.00', Item.ValorUnitario);

      Self.BtnGravar.Click();
      
      Self.MtbPedido.Edit();
      Self.MtbPedidoCodItem.AsInteger := Item.Codigo;
      Self.MtbPedido.Post();
    end;
  end;
end;

procedure TFrmPedido.BtnGravarClick(Sender: TObject);
begin
  if Self.EdtProduto.Text = '' then
  begin
    raise Exception.Create('Código do Produto precisa ser preenchido!');
  end;

  if Self.EdtValorUnitario.Text <> '' then
  begin
    Self.EdtValorTotal.Text := FormatFloat('###0.00', StrToFloat(Self.EdtValorUnitario.Text) * Self.SedQuantidade.Value);
  end;

  if not (Self.MtbPedido.State = TDataSetState.dsEdit) then
  begin
    Self.MtbPedido.Append();
  end;

  Self.MtbPedidoCodProduto.AsInteger     := StrToInt(Self.EdtProduto.Text);
  Self.MtbPedidoDescricao.AsString       := Self.EdtDesc.Text;
  Self.MtbPedidoValorUnitario.AsCurrency := StrToCurr(Self.EdtValorUnitario.Text);
  Self.MtbPedidoQuantidade.AsInteger     := Self.SedQuantidade.Value;
  Self.MtbPedidoValorTotal.AsCurrency    := StrToCurr(Self.EdtValorTotal.Text);
  Self.MtbPedido.Post();
  Self.LimparCampos();
  Self.TotalizarPedido();
end;

procedure TFrmPedido.BtnGravarPedidoClick(Sender: TObject);
var
  I,J: Integer;
begin
  if (Self.MtbPedido.RecordCount < 1) or (Self.FCliente = nil) or not (Self.FCliente.Codigo > 0) then
  begin
    raise Exception.Create('O Pedido precisa de um cliente e pelo menos um item!');
  end;

  if (FPedido = nil) or not (FPedido.NumPedido > 0) then
  begin
    FPedido := TPedido.Create();
    FPedido.CodCliente := Self.FCliente.Codigo;
  end;

  Self.MtbPedido.First();
  for I := 0 to Self.MtbPedido.RecordCount - 1 do
  begin
    if Self.MtbPedidoCodItem.AsInteger > 0 then
    begin
      for J := 0 to FPedido.Itens.Count -1 do
      begin
        if FPedido.Itens[J].Codigo = Self.MtbPedidoCodItem.AsInteger then
        begin
          FPedido.Itens[I].CodProduto := Self.MtbPedidoCodProduto.AsInteger;
          FPedido.Itens[I].Quantidade := Self.MtbPedidoQuantidade.AsInteger;
          FPedido.Itens[I].ValorUnitario := Self.MtbPedidoValorUnitario.AsCurrency;
          Break;
        end;
      end;
    end
    else
    begin
      FPedido.Itens.Add(TItemPedido.Create());

      FPedido.Itens[I].CodProduto := Self.MtbPedidoCodProduto.AsInteger;
      FPedido.Itens[I].Quantidade := Self.MtbPedidoQuantidade.AsInteger;
      FPedido.Itens[I].ValorUnitario := Self.MtbPedidoValorUnitario.AsCurrency;
    end;

    Self.MtbPedido.Next();
  end;

  FPedido.Gravar();

  if FPedido.NumPedido > 0 then
  begin
    for I := 0 to FPedido.Itens.Count - 1 do
    begin
      if not (FPedido.Itens[I].Codigo > 0) then
      begin
        Self.EdtEditarPedido.Text := FPedido.NumPedido.ToString();
        Self.BtnEditar.Click();
        raise Exception.Create('Um ou mais itens apresentaram problema ao gravar! Pedido foi carregado novamente!');
      end;
    end;
    Self.LimparTela();
  end
  else
  begin
    raise Exception.Create('Não foi possivel gravar o pedido!');
  end;
end;

procedure TFrmPedido.DbgPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_Return:
    begin
      Self.MtbPedido.Edit();
      Self.EdtProduto.Text       := Self.MtbPedidoCodProduto.AsString;
      Self.EdtDesc.Text          := Self.MtbPedidoDescricao.AsString;
      Self.EdtValorUnitario.Text := FormatFloat('###0.00', Self.MtbPedidoValorUnitario.AsFloat);
      Self.SedQuantidade.Value   := Self.MtbPedidoQuantidade.AsInteger;
      Self.EdtValorTotal.Text    := FormatFloat('###0.00', Self.MtbPedidoValorTotal.AsFloat);

      Self.EdtProduto.ReadOnly := True;
    end;
    VK_Delete:
    begin
      if MessageDlg('Deseja deletar o item ' + Self.MtbPedidoDescricao.Text + '?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then
      begin
        Self.MtbPedido.Delete();
      end;
    end;
  end;
end;

procedure TFrmPedido.EdtClienteExit(Sender: TObject);
begin
  if Self.EdtCliente.Text <> '' then
  begin
    Self.BtnCliente.Click();
  end;
end;

procedure TFrmPedido.EdtProdutoExit(Sender: TObject);
begin
  if Self.EdtProduto.Text <> '' then
  begin
    Self.PreencherProduto();
  end;
end;

procedure TFrmPedido.EdtValorUnitarioExit(Sender: TObject);
begin
  if Self.EdtValorUnitario.Text <> '' then
  begin
    Self.EdtValorUnitario.Text := FormatFloat('###0.00', StrToFloat(Self.EdtValorUnitario.Text));
  end;
end;

procedure TFrmPedido.EdtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',', #9, #8, #13]) then
  begin
    Key := #0;
  end;
end;

procedure TFrmPedido.FormCreate(Sender: TObject);
begin
  //Self.FConexao := TConexao.ObterInstancia();
  //Self.FConexao.GerarConexao(ParamStr(1), ParamStr(2), ParamStr(3));
  //Self.FConexao.Conectar();

  Self.MtbPedido.Open();
end;

procedure TFrmPedido.LimparCampos();
begin
  Self.EdtProduto.Text       := '';
  Self.EdtDesc.Text          := '';
  Self.EdtValorUnitario.Text := '';
  Self.SedQuantidade.Value   := 0;
  Self.EdtValorTotal.Text    := '';
  Self.EdtProduto.ReadOnly   := False;
end;

procedure TFrmPedido.PreencherProduto();
var
  Produto : TProduto;
begin
  Produto := TProduto.Create(StrToInt(Self.EdtProduto.Text));
  if Produto.Codigo > 0 then
  begin
    Self.EdtDesc.Text          := Produto.Descricao;
    Self.EdtValorUnitario.Text := FormatFloat('###0.00', Produto.PrecoVenda);
  end
  else
  begin
    raise Exception.Create('Produto não encontrado!');
  end;
end;

procedure TFrmPedido.CalcularPrecoTotalItem(Sender: TObject);
begin
  if Self.EdtValorUnitario.Text <> '' then
  begin
    Self.EdtValorTotal.Text := FormatFloat('###0.00', StrToFloat(Self.EdtValorUnitario.Text) * Self.SedQuantidade.Value);
  end;
end;

procedure TFrmPedido.TotalizarPedido();
var
  I: Integer;
  TotalPedido: Currency;
begin
  Self.MtbPedido.First();
  TotalPedido := 0;
  for I := 0 to Self.MtbPedido.RecordCount - 1 do
  begin
    TotalPedido := TotalPedido + Self.MtbPedidoValorTotal.AsCurrency;
    Self.MtbPedido.Next();
  end;
  Self.LblValorTotal.Caption := FormatFloat('R$ ###0.00', TotalPedido);
end;

procedure TFrmPedido.LimparTela();
begin
  Self.MtbPedido.Close();
  Self.MtbPedido.Open();
  
  Self.BtnEditar.Visible := True;
  Self.BtnEditar.Enabled := True;
  Self.BtnDeletarPedido.Visible := True;
  Self.BtnDeletarPedido.Enabled := True;
  Self.EdtEditarPedido.Visible := True;
  Self.EdtEditarPedido.Enabled := True;
  
  Self.EdtCliente.Text := '';
  Self.EdtNomeCliente.Text := '';
  Self.EdtEditarPedido.Text := '';
  
  FreeAndNil(Self.FCliente);
  FreeAndNil(Self.FPedido);

  Self.TotalizarPedido();
end;

end.
