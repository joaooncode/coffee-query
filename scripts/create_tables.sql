CREATE TABLE IF NOT EXISTS cargo
(
    id_cargo     SERIAL PRIMARY KEY NOT NULL,
    titulo       VARCHAR(60)        NOT NULL,
    descricao    TEXT               NOT NULL,
    salario_base NUMERIC(15, 2)     NOT NULL,
    ativo        BOOLEAN            NOT NULL DEFAULT TRUE,
    created_at   timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS turno
(
    id_turno    SERIAL PRIMARY KEY NOT NULL,
    titulo      VARCHAR(60)        NOT NULL,
    hora_inicio TIME               NOT NULL,
    hora_fim    TIME               NOT NULL,
    ativo       BOOLEAN            NOT NULL DEFAULT TRUE,
    created_at  timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP

);

CREATE TABLE IF NOT EXISTS funcionario
(
    id_funcionario SERIAL PRIMARY KEY NOT NULL,
    id_cargo_fk    INTEGER            NOT NULL REFERENCES cargo (id_cargo),
    nome           VARCHAR(100)       NOT NULL,
    cpf            VARCHAR(11)        NOT NULL UNIQUE,
    email          VARCHAR(120)       NOT NULL UNIQUE,
    telefone       VARCHAR(20)        NOT NULL UNIQUE,
    salario        NUMERIC(15, 2)     NOT NULL,
    data_admissao  DATE               NOT NULL,
    data_demissao  DATE               NOT NULL,
    ativo          BOOLEAN            NOT NULL DEFAULT TRUE,
    created_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at     timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS escala
(
    id_escala         SERIAL PRIMARY KEY NOT NULL,
    id_funcionario_fk INTEGER            NOT NULL REFERENCES funcionario (id_funcionario),
    data              DATE               NOT NULL,
    ativo             BOOLEAN            NOT NULL DEFAULT TRUE,
    created_at        timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        timestamptz        NOT NULL DEFAULT CURRENT_TIMESTAMP
)