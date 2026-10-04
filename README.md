# Banco de Dados Cafeteria

Modelo de banco de dados relacional para uma cafeteria, cobrindo pedidos e vendas, estoque e compras de insumos, e
funcionários e escalas. O banco roda em PostgreSQL 16 dentro de um container Docker e é criado automaticamente na
primeira subida.

## Tecnologias

- **PostgreSQL 16** (imagem `postgres:16-alpine`)
- **Docker Compose** para subir o banco localmente
- **DBML** ([dbdiagram.io](https://dbdiagram.io)) e **QuickDBD** para o diagrama entidade-relacionamento

## Estrutura de pastas

```
.
├── diagrama/
│   ├── cafeteria.dbml           # diagrama em DBML (fonte do modelo)
│   └── cafeteria-quickdbd.txt   # o mesmo modelo no formato do QuickDBD
└── docker/
    ├── docker-compose.yaml      # serviço postgres
    ├── .env.example             # variáveis de ambiente (copiar para .env)
    └── init/
        └── 01-schema.sql        # DDL: 18 tabelas, constraints e índices
```

O `01-schema.sql` foi gerado a partir do `cafeteria.dbml`. Se o diagrama mudar, o SQL precisa ser atualizado junto.

## Como subir o banco

Pré-requisito: Docker com o plugin Compose.

```bash
cd docker
cp .env.example .env      # troque POSTGRES_PASSWORD no .env
docker compose up -d
docker compose ps         # aguarde o status "healthy"
```

Na primeira subida, com o volume vazio, o Postgres executa em ordem alfabética os scripts de `docker/init/`, criando
todas as tabelas. O container usa o fuso `America/Sao_Paulo`.

## Como conectar

Valores padrão (definidos no `.env`):

| Parâmetro | Valor                    |
|-----------|--------------------------|
| Host      | `localhost`              |
| Porta     | `5432` (`POSTGRES_PORT`) |
| Banco     | `coffee_query`           |
| Usuário   | `joaosilvadev`           |
| Senha     | `POSTGRES_PASSWORD`      |

Pelo `psql` dentro do container:

```bash
docker compose exec postgres psql -U joaosilvadev -d coffee_query
```

Qualquer cliente (DBeaver, pgAdmin, DataGrip) também conecta com os dados acima.

## Como recriar do zero

Os scripts de `init/` só rodam quando o volume está vazio. Para aplicar uma mudança no schema, apague o volume e suba de
novo:

```bash
cd docker
docker compose down -v    # remove o container e o volume cafeteria-data (apaga todos os dados)
docker compose up -d
```

Novos scripts (por exemplo, carga de dados) devem entrar como `init/02-*.sql`, `init/03-*.sql` e assim por diante, para
rodar depois do schema.

## Tabelas

São 18 tabelas, organizadas em três áreas.

### Funcionários

| Tabela        | Descrição                                                            |
|---------------|----------------------------------------------------------------------|
| `cargo`       | Cargos e salário base                                                |
| `funcionario` | Funcionários, com cargo, CPF, datas de admissão e demissão e salário |
| `turno`       | Turnos de trabalho (manhã, tarde, noite) com horário de início e fim |
| `escala`      | Qual funcionário trabalha em qual turno e em que data                |

### Pedidos e vendas

| Tabela              | Descrição                                                                                                                                   |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| `cliente`           | Clientes cadastrados e pontos de fidelidade                                                                                                 |
| `mesa`              | Mesas do salão e capacidade                                                                                                                 |
| `pedido`            | Pedido com atendente, cliente (opcional), mesa (opcional), tipo de consumo (balcão, mesa, viagem, delivery), status, desconto e valor total |
| `categoria_produto` | Categorias do cardápio (cafés, chás, salgados, doces)                                                                                       |
| `produto`           | Itens do cardápio e preço de venda                                                                                                          |
| `item_pedido`       | Produtos de cada pedido, com quantidade e preço no momento da venda                                                                         |
| `forma_pagamento`   | Dinheiro, Pix, débito, crédito                                                                                                              |
| `pagamento`         | Pagamentos de um pedido (permite dividir em mais de uma forma)                                                                              |

### Estoque e compras

| Tabela                 | Descrição                                                                                            |
|------------------------|------------------------------------------------------------------------------------------------------|
| `insumo`               | Matérias-primas e descartáveis, com unidade (g, ml, un), estoque atual, estoque mínimo e custo médio |
| `ficha_tecnica`        | Quanto de cada insumo um produto consome por unidade                                                 |
| `fornecedor`           | Fornecedores (razão social, CNPJ)                                                                    |
| `compra`               | Compras a fornecedores, com status (pendente, recebida, cancelada)                                   |
| `item_compra`          | Insumos de cada compra, com quantidade e custo unitário                                              |
| `movimentacao_estoque` | Entradas, saídas, ajustes e perdas de insumos, ligadas à compra ou ao pedido de origem               |

As regras de negócio que cabem em constraints (valores não negativos, listas de status, datas coerentes, vínculo de
movimentação com compra ou pedido) estão em `CHECK`s no `01-schema.sql`, e as chaves estrangeiras mais consultadas têm
índice.

## Visualizar o diagrama

1. Abra [dbdiagram.io](https://dbdiagram.io) e clique em **Go to App**.
2. Apague o conteúdo do editor à esquerda.
3. Cole todo o conteúdo de `diagrama/cafeteria.dbml`.

O diagrama aparece à direita. Para usar o QuickDBD, cole `diagrama/cafeteria-quickdbd.txt` no editor
de [app.quickdatabasediagrams.com](https://app.quickdatabasediagrams.com).

## Roadmap

O projeto é acompanhado no épico [ES-31](https://geopromo.atlassian.net/browse/ES-31) do Jira. Até agora existem a
modelagem e o schema; as demais etapas ainda não foram iniciadas.

| Etapa | Tarefa                                         | Situação     |
|-------|------------------------------------------------|--------------|
| 1     | Modelagem e criação do schema (DDL)            | em andamento |
| 2     | Carga de dados fictícios                       | a fazer      |
| 3     | Functions (PL/pgSQL)                           | a fazer      |
| 4     | Stored procedures                              | a fazer      |
| 5     | Triggers                                       | a fazer      |
| 6     | Views operacionais e gerenciais                | a fazer      |
| 7     | Camada analítica (schema `bi`) para o Power BI | a fazer      |
| 8     | Integração e dashboard no Power BI             | a fazer      |
| 9     | Testes, documentação e entrega                 | a fazer      |
