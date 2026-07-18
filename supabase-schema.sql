-- BAI Portal - Schema Supabase
-- Executar no SQL Editor do Supabase Dashboard

CREATE TABLE IF NOT EXISTS submissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  province TEXT NOT NULL,
  user_id TEXT NOT NULL,
  municipality TEXT NOT NULL,
  neighborhood TEXT NOT NULL,
  services TEXT[] NOT NULL DEFAULT '{}',
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'contacted', 'completed', 'cancelled')),
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT true,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Insert default services
INSERT INTO services (name, active, sort_order) VALUES
  ('Actualizar Aplicativo', true, 1),
  ('Activar notificações de movimentos', true, 2),
  ('Obter cartão visa', true, 3),
  ('Obter TPA', true, 4),
  ('Fazer agendamento on-line', true, 5),
  ('Recuperar credenciais', true, 6),
  ('Obter crédito', true, 7)
ON CONFLICT (name) DO NOTHING;

-- Enable Row Level Security (optional, for production)
ALTER TABLE submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;

-- Allow public access (since we use anon key)
CREATE POLICY "Allow public access to submissions" ON submissions FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Allow public access to services" ON services FOR ALL USING (true) WITH CHECK (true);
