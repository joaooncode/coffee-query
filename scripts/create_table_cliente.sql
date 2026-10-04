CREATE TABLE IF NOT EXISTS cliente
(
    id_cliente        SERIAL PRIMARY KEY  NOT NULL,
    nome              VARCHAR(100)        NOT NULL,
    cpf               VARCHAR(11) UNIQUE  NOT NULL,
    email             VARCHAR(120) UNIQUE NOT NULL,
    telefone          VARCHAR(20)         NOT NULL,
    ativo             BOOLEAN             NOT NULL DEFAULT TRUE,
    pontos_fidelidade INTEGER             NOT NULL DEFAULT 0,
    created_at        timestamptz         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        timestamptz         NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS mesa
(
    id_mesa    SERIAL PRIMARY KEY NOT NULL,
    numero     INTEGER            NOT NULL,
    capacidade INTEGER            NOT NULL,
    ativo      BOOLEAN DEFAULT TRUE
);


CREATE TABLE IF NOT EXISTS categoria_produto
(
    id_categoria SERIAL PRIMARY KEY NOT NULL,
    descricao    VARCHAR(100)       NOT NULL,
    observacao   TEXT               NULL,
    created_at   timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS produto
(
    id_produto      SERIAL PRIMARY KEY NOT NULL,
    id_categoria_fk INTEGER            NOT NULL REFERENCES categoria_produto (id_categoria),
    descricao       VARCHAR(120)       NOT NULL,
    preco_venda     NUMERIC(15, 2)     NOT NULL,
    ativo           BOOLEAN            NOT NULL DEFAULT TRUE,
    created_at      timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);