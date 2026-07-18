-- =====================================================
-- Bolt Workspace
-- Migration: 003_rbac.sql
-- Description: Roles and User Roles
-- =====================================================

-- Create roles table
CREATE TABLE public.roles (
    id SMALLSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Seed default roles
INSERT INTO public.roles (name, description)
VALUES
('CEO', 'Chief Executive Officer'),
('Staff', 'General Staff');

-- Add role_id to profiles
ALTER TABLE public.profiles
ADD COLUMN role_id SMALLINT;

-- Create foreign key
ALTER TABLE public.profiles
ADD CONSTRAINT fk_profiles_role
FOREIGN KEY (role_id)
REFERENCES public.roles(id);

-- Create index
CREATE INDEX idx_profiles_role
ON public.profiles(role_id);