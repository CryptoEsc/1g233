CREATE TABLE users (
    id SERIAL PRIMARY KEY,                     -- ID único do usuário
    username VARCHAR(255) UNIQUE NOT NULL,    -- Nome de usuário único
    email VARCHAR(255) UNIQUE NOT NULL,       -- Email único
    hashed_password VARCHAR(255) NOT NULL,    -- Senha criptografada
    cpf VARCHAR(14) UNIQUE NOT NULL,          -- CPF único
    balance FLOAT DEFAULT 0.0,                -- Saldo inicial em GC$
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data de criação
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data de atualização
);

-- Criar uma função para atualizar automaticamente o campo updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar um trigger para chamar a função sempre que a tabela for atualizada
CREATE TRIGGER set_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();