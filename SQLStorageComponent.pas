unit SQLStorageComponent;

interface

uses
  System.Classes, System.SysUtils;

type
  TSQLItem = class(TCollectionItem)
  private
    FIdentifier: string;
    FSQL: TStrings;
    procedure SetSQL(const Value: TStrings);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Identifier: string read FIdentifier write FIdentifier;
    property SQL: TStrings read FSQL write SetSQL;
  end;

  TSQLCollection = class(TOwnedCollection)
  public
    function FindByIdentifier(const Identifier: string): TSQLItem;
  end;

  TSQLStorage = class(TComponent)
  private
    FSQLItems: TSQLCollection;
    procedure SetSQLItems(const Value: TSQLCollection);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetSQL(const Identifier: string): TStrings;
  published
    property SQLItems: TSQLCollection read FSQLItems write SetSQLItems;
  end;

procedure Register;

implementation

{ TSQLItem }

constructor TSQLItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSQL := TStringList.Create; // Inicializa o TStrings
end;

destructor TSQLItem.Destroy;
begin
  FSQL.Free; // Libera o TStrings
  inherited Destroy;
end;

procedure TSQLItem.SetSQL(const Value: TStrings);
begin
  FSQL.Assign(Value); // Copia os valores do TStrings
end;

{ TSQLCollection }

function TSQLCollection.FindByIdentifier(const Identifier: string): TSQLItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if TSQLItem(Items[I]).Identifier = Identifier then
      Exit(TSQLItem(Items[I]));
end;

{ TSQLStorage }

constructor TSQLStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSQLItems := TSQLCollection.Create(Self, TSQLItem);
end;

destructor TSQLStorage.Destroy;
begin
  FSQLItems.Free;
  inherited Destroy;
end;

procedure TSQLStorage.SetSQLItems(const Value: TSQLCollection);
begin
  FSQLItems.Assign(Value);
end;

function TSQLStorage.GetSQL(const Identifier: string): TStrings;
var
  Item: TSQLItem;
begin
  Item := FSQLItems.FindByIdentifier(Identifier);
  if Assigned(Item) then
    Result := Item.SQL
  else
    raise Exception.CreateFmt('Identificador "%s" não encontrado.', [Identifier]);
end;

procedure Register;
begin
  RegisterComponents('Pessoal', [TSQLStorage]);
end;

end.
