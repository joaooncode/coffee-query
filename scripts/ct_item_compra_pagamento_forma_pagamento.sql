CREATE TABLE IF NOT EXISTS item_compra
(
    id_compra      SERIAL PRIMARY KEY NOT NULL,
    id_insumo_fk   INTEGER            NOT NULL REFERENCES insumo (id_insumo),
    quantidade     NUMERIC(12, 3)     NOT NULL,
    custo_unitario NUMERIC(15, 2)     NOT NULL,
    created_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS forma_pagamento
(
    id_forma_pagamento SERIAL PRIMARY KEY NOT NULL,
    descricao          VARCHAR(60)        NOT NULL,
    ativo              BOOLEAN            NOT NULL DEFAULT TRUE,
    created_at         timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at         timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pagamento
(
    id_pagamento          SERIAL PRIMARY KEY NOT NULL,
    id_pedido_fk          INTEGER            NOT NULL REFERENCES pedido (id_pedido),
    id_forma_pagamento_fk INTEGER            NOT NULL REFERENCES forma_pagamento (id_forma_pagamento),
    valor                 NUMERIC(15, 2)     NOT NULL,
    created_at            timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at            timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS pedido
(
    id_pedido         SERIAL PRIMARY KEY NOT NULL,
    id_cliente_fk     INTEGER            NOT NULL REFERENCES cliente (id_cliente),
    id_funcionario_fk INTEGER            NOT NULL REFERENCES funcionario (id_funcionario),
    id_mesa_fk        INTEGER            NOT NULL REFERENCES mesa (id_mesa),
    tipo_consumo      VARCHAR(60)        NOT NULL,
    status            VARCHAR(60)        NOT NULL,
    desconto          NUMERIC(15, 2)     NULL,
    valor_total       NUMERIC(15, 2)     NOT NULL,
    created_at        timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS item_pedido
(
    id_item_pedido SERIAL PRIMARY KEY NOT NULL,
    id_pedido_fk   INTEGER            NOT NULL REFERENCES pedido (id_pedido),
    id_produto_fk  INTEGER            NOT NULL REFERENCES produto (id_produto),
    quantidade     INTEGER            NOT NULL,
    preco_unitario NUMERIC(15, 2)     NOT NULL,
    observacao     TEXT               NULL,
    created_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS movimentacao_estoque
(
    id_movimentacao_estoque SERIAL PRIMARY KEY NOT NULL,
    id_insumo_fk            INTEGER            NOT NULL REFERENCES insumo (id_insumo),
    id_funcionario          INTEGER            NOT NULL REFERENCES funcionario (id_funcionario),
    id_compra               INTEGER            NOT NULL REFERENCES compra (id_compra),
    tipo                    VARCHAR(30)        NOT NULL,
    quantidade              NUMERIC(15, 2)     NOT NULL,
    observacao              TEXT,
    created_at              timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at              timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);