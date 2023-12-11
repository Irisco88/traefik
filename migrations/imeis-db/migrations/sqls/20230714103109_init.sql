-- +goose Up
-- +goose StatementBegin
CREATE TABLE imeis
(
    id SERYAL PRIMARY KEY,
    imeis_name VARCHAR(255) NOT NULL,
    device_name  VARCHAR(255),
    owner_id   INTEGER      NOT NULL DEFAULT 0,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX idx_imeis_unique_imeis_nam ON imeis (imeis_name);
CREATE UNIQUE INDEX idx_imeis_unique_device_name ON imeis (device_name);

CREATE EXTENSION IF NOT EXISTS pgcrypto;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS imeis;
-- +goose StatementEnd
