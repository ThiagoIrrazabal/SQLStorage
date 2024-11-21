# TSQLStorage Component

**TSQLStorage** é um componente Delphi não-visual que permite armazenar e gerenciar consultas SQL associadas a identificadores. Ele facilita o gerenciamento centralizado de SQLs no Design-Time e Runtime, com suporte a múltiplas linhas para as consultas.

---

## 🛠️ Funcionalidades

- Armazene múltiplos SQLs associados a identificadores únicos.
- Edição intuitiva no **Design-Time**, com um editor visual integrado.
- Suporte para múltiplas linhas de SQL (`TStrings`).
- Acesse e manipule os SQLs programaticamente no **Runtime**.

---

## 📂 Instalação

1. Copie o arquivo `SQLStorageComponent.pas` para o seu projeto ou diretório de componentes.
2. Abra o Delphi e adicione o arquivo ao projeto:
   - **File > Open > SQLStorageComponent.pas**.
3. Compile e registre o componente:
   - **Component > Install Component...**
   - Escolha um pacote existente ou crie um novo.
4. O componente estará disponível na paleta **Pessoal**.

---

## 🧰 Propriedades

### `SQLItems`
- **Tipo:** `TSQLCollection`
- **Descrição:** Coleção de itens que armazenam:
  - `Identifier`: Nome único para identificar o SQL.
  - `SQL`: Consulta SQL (múltiplas linhas) associada ao identificador.

---

## 🚀 Uso

### No Design-Time

1. Arraste o componente `TSQLStorage` para o formulário.
2. No **Object Inspector**, clique na propriedade `SQLItems`.
3. No editor de coleção:
   - Adicione novos itens clicando em **Add**.
   - Configure os seguintes campos:
     - **Identifier**: Nome único para o SQL.
     - **SQL**: Edite o SQL no editor de múltiplas linhas (`...`).

### No Runtime

Adicione, remova ou acesse os SQLs programaticamente.

#### Adicionando SQLs no Runtime
```delphi
SQLStorage.SQLItems.Add.Identifier := 'GetAllUsers';
SQLStorage.SQLItems.Add.SQL.Text := 'SELECT * FROM Users ORDER BY Name';
```
#### Recuperando SQL por Identificador
```delphi
ShowMessage(SQLStorage.GetSQL('GetAllUsers').Text);
```
#### Editando SQL em Tempo de Execução
```delphi
SQLStorage.GetSQL('GetAllUsers').Add('WHERE IsActive = 1');
```
#### Removendo SQL por Identificador
```delphi
SQLStorage.SQLItems.Delete(0); // Remove o primeiro item da coleção
```
#### 🧪 Exemplo Completo
```delphi
var
  SQLStorage: TSQLStorage;
  SQLText: TStrings;
begin
  SQLStorage := TSQLStorage.Create(nil);
  try
    // Adiciona um novo SQL
    with SQLStorage.SQLItems.Add as TSQLItem do
    begin
      Identifier := 'GetActiveUsers';
      SQL.Text := 'SELECT * FROM Users WHERE IsActive = 1';
    end;

    // Recupera e exibe o SQL
    SQLText := SQLStorage.GetSQL('GetActiveUsers');
    ShowMessage(SQLText.Text);
  finally
    SQLStorage.Free;
  end;
end;
```
