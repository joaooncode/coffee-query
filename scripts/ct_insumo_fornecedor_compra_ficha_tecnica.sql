CREATE TABLE IF NOT EXISTS insumo
(
    id_insumo      SERIAL PRIMARY KEY NOT NULL,
    descricao      VARCHAR(120)       NOT NULL,
    unidade_medida VARCHAR(10)        NOT NULL,
    estoque_atual  NUMERIC(12, 3)     NOT NULL,
    estoque_minimo NUMERIC(12, 3)     NOT NULL,
    custo_medio    NUMERIC(15, 2)     NOT NULL,
    created_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS fornecedor
(
    id_fornecedor SERIAL PRIMARY KEY  NOT NULL,
    razao_social  VARCHAR(150) UNIQUE NOT NULL,
    cnpj          VARCHAR(20) UNIQUE  NOT NULL,
    telefone      VARCHAR(20)         NOT NULL,
    email         VARCHAR(120) UNIQUE NOT NULL,
    created_at    timestamptz         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    timestamptz         NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS compra
(
    id_compra         SERIAL PRIMARY KEY NOT NULL,
    id_fornecedor_fk  INTEGER            NOT NULL REFERENCES fornecedor (id_fornecedor),
    id_funcionario_fk INTEGER            NOT NULL REFERENCES funcionario (id_funcionario),
    status            varchar(10)        NOT NULL,
    created_at        timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ficha_tecnica
(
    id_ficha_tecnica SERIAL PRIMARY KEY NOT NULL,
    id_produto_fk    INTEGER            NOT NULL REFERENCES produto (id_produto),
    id_insumo_fk     INTEGER            NOT NULL REFERENCES insumo (id_insumo)
);