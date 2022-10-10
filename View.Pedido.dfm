object FrmPedido: TFrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido'
  ClientHeight = 392
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    718
    392)
  TextHeight = 15
  object LblValorTotal: TLabel
    Left = 524
    Top = 352
    Width = 56
    Height = 19
    Anchors = [akLeft, akBottom]
    Caption = 'R$ 0,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DbgPedido: TDBGrid
    Left = 8
    Top = 69
    Width = 699
    Height = 244
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DsPedido
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnKeyDown = DbgPedidoKeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CodItem'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'd. Item'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CodProduto'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'd. Produto'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Alignment = taCenter
        Title.Caption = 'Descr'#231#227'o'
        Width = 200
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'Quantidade'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ValorUnitario'
        Title.Alignment = taCenter
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ValorTotal'
        Title.Alignment = taCenter
        Title.Caption = 'Valor Total'
        Width = 80
        Visible = True
      end>
  end
  object EdtProduto: TEdit
    Left = 8
    Top = 348
    Width = 113
    Height = 23
    Anchors = [akLeft, akBottom]
    NumbersOnly = True
    TabOrder = 1
    TextHint = 'C'#243'digo do produto'
    OnExit = EdtProdutoExit
    ExplicitTop = 347
  end
  object BtnGravar: TButton
    Left = 443
    Top = 348
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Gravar Item'
    TabOrder = 2
    OnClick = BtnGravarClick
    ExplicitTop = 347
  end
  object SedQuantidade: TSpinEdit
    Left = 127
    Top = 348
    Width = 58
    Height = 24
    Anchors = [akLeft, akBottom]
    MaxValue = 1000000
    MinValue = 1
    TabOrder = 3
    Value = 1
    OnChange = CalcularPrecoTotalItem
    ExplicitTop = 347
  end
  object EdtValorUnitario: TEdit
    Left = 191
    Top = 348
    Width = 120
    Height = 23
    Anchors = [akLeft, akBottom]
    TabOrder = 4
    TextHint = 'Valor Unit'#225'rio'
    OnChange = CalcularPrecoTotalItem
    OnExit = EdtValorUnitarioExit
    OnKeyPress = EdtValorUnitarioKeyPress
    ExplicitTop = 347
  end
  object EdtDesc: TEdit
    Left = 8
    Top = 319
    Width = 699
    Height = 23
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    TabOrder = 5
    TextHint = 'Produto'
    ExplicitTop = 318
    ExplicitWidth = 695
  end
  object EdtValorTotal: TEdit
    Left = 317
    Top = 348
    Width = 120
    Height = 23
    Anchors = [akLeft, akBottom]
    ReadOnly = True
    TabOrder = 6
    TextHint = 'Valor Total'
    OnExit = EdtValorUnitarioExit
    OnKeyPress = EdtValorUnitarioKeyPress
    ExplicitTop = 347
  end
  object BtnCliente: TButton
    Left = 127
    Top = 9
    Width = 109
    Height = 25
    Caption = 'Selecionar Cliente'
    TabOrder = 7
    OnClick = BtnClienteClick
  end
  object EdtCliente: TEdit
    Left = 8
    Top = 10
    Width = 113
    Height = 23
    NumbersOnly = True
    TabOrder = 8
    TextHint = 'C'#243'digo do Cliente'
    OnExit = EdtClienteExit
  end
  object EdtNomeCliente: TEdit
    Left = 8
    Top = 40
    Width = 699
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    NumbersOnly = True
    ReadOnly = True
    TabOrder = 9
    TextHint = 'Nome do Cliente'
    ExplicitWidth = 695
  end
  object BtnGravarPedido: TButton
    Left = 627
    Top = 349
    Width = 80
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Gravar Pedido'
    TabOrder = 10
    OnClick = BtnGravarPedidoClick
    ExplicitLeft = 623
    ExplicitTop = 348
  end
  object BtnEditar: TButton
    Left = 483
    Top = 9
    Width = 109
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Selecionar Pedido'
    TabOrder = 11
    OnClick = BtnEditarClick
  end
  object EdtEditarPedido: TEdit
    Left = 364
    Top = 10
    Width = 113
    Height = 23
    Anchors = [akTop, akRight]
    NumbersOnly = True
    TabOrder = 12
    TextHint = 'C'#243'digo do Pedido'
  end
  object BtnDeletarPedido: TButton
    Left = 598
    Top = 9
    Width = 109
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Deletar Pedido'
    TabOrder = 13
    OnClick = BtnDeletarPedidoClick
  end
  object MtbPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 120
    object MtbPedidoCodItem: TIntegerField
      FieldName = 'CodItem'
    end
    object MtbPedidoCodProduto: TIntegerField
      FieldName = 'CodProduto'
    end
    object MtbPedidoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object MtbPedidoQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object MtbPedidoValorUnitario: TCurrencyField
      FieldName = 'ValorUnitario'
    end
    object MtbPedidoValorTotal: TCurrencyField
      FieldName = 'ValorTotal'
    end
  end
  object DsPedido: TDataSource
    DataSet = MtbPedido
    Left = 128
    Top = 120
  end
end
